Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09D226FB22
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Sep 2020 13:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgIRLDm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Sep 2020 07:03:42 -0400
Received: from m42-11.mailgun.net ([69.72.42.11]:31133 "EHLO
        m42-11.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRLDm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Sep 2020 07:03:42 -0400
X-Greylist: delayed 308 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 07:03:38 EDT
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600427021; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=6Vd/nxQn6PZZdVh1QZpRQW/9ncnnN6YaMbomCFPyUKs=;
 b=atOD5QsNc9jQxHlp3AtwBGHv45xUFKIK6VY39Oe78F4mHySHLTK4h+mWD7jwTx3BFC7xIHtT
 Oz/6JoeNtLG8noH2WJx9lsC3hFeplm5BCXIxMKbSNKzxbXJD2B7UfYroY2aP+cgE88AST9Ry
 /kNTHhF+qvqy917T1GuyE6lErY4=
X-Mailgun-Sending-Ip: 69.72.42.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f6492c66b1937bb6548c167 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Sep 2020 10:58:14
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 15BD9C433FF; Fri, 18 Sep 2020 10:58:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 84F40C433CB;
        Fri, 18 Sep 2020 10:58:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 18 Sep 2020 18:58:13 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     John Crispin <john@phrozen.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org,
        Shashidhar Lakkavalli <slakkavalli@datto.com>,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH V2] ath11k: add tx hw 802.11 encapusaltion offloading
 support
In-Reply-To: <20200430152814.18481-1-john@phrozen.org>
References: <20200430152814.18481-1-john@phrozen.org>
Message-ID: <0b4abf6c2b7408664cacff5392902720@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-04-30 23:28, John Crispin wrote:
> This patch adds support for ethernet rxtx mode to the driver. The 
> feature
> is enabled via a new module parameter. If enabled to driver will enable
> the feature on a per vif basis if all other requirements were met.
> 
[...]
> @@ -4339,7 +4352,22 @@ static int ath11k_mac_op_add_interface(struct
> ieee80211_hw *hw,
>  	spin_unlock_bh(&ar->data_lock);
> 
>  	param_id = WMI_VDEV_PARAM_TX_ENCAP_TYPE;
> -	param_value = ATH11K_HW_TXRX_NATIVE_WIFI;
> +	if (ath11k_ath11k_frame_mode == ATH11K_HW_TXRX_ETHERNET)
> +		switch (vif->type) {
> +		case NL80211_IFTYPE_STATION:
> +		case NL80211_IFTYPE_AP_VLAN:
> +		case NL80211_IFTYPE_AP:
> +			hw_encap = 1;
> +			break;
> +		default:
> +			break;
> +		}
> +
> +	if (ieee80211_set_hw_80211_encap(vif, hw_encap))
I see ieee80211_set_hw_80211_encap have check like this:
if (key->conf.cipher == WLAN_CIPHER_SUITE_TKIP)
         enable = false;

so is it beeter to call it after associated/install key?
> +		param_value = ATH11K_HW_TXRX_ETHERNET;
> +	else
> +		param_value = ATH11K_HW_TXRX_NATIVE_WIFI;
> +
>  	ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
>  					    param_id, param_value);
>  	if (ret) {
