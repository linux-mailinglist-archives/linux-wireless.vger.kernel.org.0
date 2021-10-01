Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE4141EFF0
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 16:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhJAOsL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Oct 2021 10:48:11 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:62392 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231737AbhJAOsL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Oct 2021 10:48:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633099585; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=kVwF6Xqim2UQyBLU9qjnxqOgCbV4J8q8/sqZaErgqhY=; b=NbQvZV8Gjq3Ua2Xdfqf0QLm8v+zMYgajavToR2V26L9X5a+nv3ZJvm3+kx1us1sYldPszw1J
 S19lzrT+cWOz9MG3noItci86R/Z0fM4CT34X8oSuSJ597EKF7Na7IhXOPDbzhTtB58GcPEZE
 STrblhVAgrm8j8uSlAE/DgJtMx4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 61571f4047d64efb6dfc527d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 01 Oct 2021 14:46:24
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 70D22C43460; Fri,  1 Oct 2021 14:46:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1FB95C43460;
        Fri,  1 Oct 2021 14:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 1FB95C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 01/24] rtw89: add CAM files
References: <20210820043538.12424-1-pkshih@realtek.com>
        <20210820043538.12424-2-pkshih@realtek.com>
Date:   Fri, 01 Oct 2021 17:46:19 +0300
In-Reply-To: <20210820043538.12424-2-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Fri, 20 Aug 2021 12:35:15 +0800")
Message-ID: <871r54kdl0.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> Three kinds of CAM, security, address and bssid, are implemented in the
> chip, and then we control them via H2C commands.
>
> Every vif contains one address and one bssid CAM entries, and both are
> allocated while vif is adding. Once any state is changed, driver notices
> firmware. For example, add/remove vif, sta assoc/disassoc, and changed
> security key.
>
> When connecting to an AP with security, a security CAM entry is allocated
> from security CAM pool and filled key values, and then attached to the
> address CAM that contains seven keys entries for unicast, group and BIP
> keys. Since the functions of these seven keys are predefined by firmware,
> we should attach key to proper position depends on security entry mode and
> key type.
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

> +int rtw89_cam_sec_key_add(struct rtw89_dev *rtwdev,
> +			  struct ieee80211_vif *vif,
> +			  struct ieee80211_sta *sta,
> +			  struct ieee80211_key_conf *key)
> +{
> +	u8 hw_key_type;
> +	bool ext_key = false;
> +	int ret;
> +
> +	switch (key->cipher) {
> +	case WLAN_CIPHER_SUITE_WEP40:
> +		hw_key_type = RTW89_SEC_KEY_TYPE_WEP40;
> +		break;
> +	case WLAN_CIPHER_SUITE_WEP104:
> +		hw_key_type = RTW89_SEC_KEY_TYPE_WEP104;
> +		break;
> +	case WLAN_CIPHER_SUITE_CCMP:
> +		hw_key_type = RTW89_SEC_KEY_TYPE_CCMP128;
> +		key->flags |= IEEE80211_KEY_FLAG_SW_MGMT_TX;
> +		break;
> +	case WLAN_CIPHER_SUITE_CCMP_256:
> +		hw_key_type = RTW89_SEC_KEY_TYPE_CCMP256;
> +		key->flags |= IEEE80211_KEY_FLAG_SW_MGMT_TX;
> +		ext_key = true;
> +		break;
> +	case WLAN_CIPHER_SUITE_GCMP:
> +		hw_key_type = RTW89_SEC_KEY_TYPE_GCMP128;
> +		key->flags |= IEEE80211_KEY_FLAG_SW_MGMT_TX;
> +		break;
> +	case WLAN_CIPHER_SUITE_GCMP_256:
> +		hw_key_type = RTW89_SEC_KEY_TYPE_GCMP256;
> +		key->flags |= IEEE80211_KEY_FLAG_SW_MGMT_TX;
> +		ext_key = true;
> +		break;
> +	case WLAN_CIPHER_SUITE_TKIP:
> +	case WLAN_CIPHER_SUITE_AES_CMAC:
> +	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
> +	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
> +	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
> +		/* suppress error messages */

What error messages? I don't understand the comment.

> +		return -EOPNOTSUPP;
> +	default:
> +		return -ENOTSUPP;

I would merge default with other cases above and have just one return
call.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
