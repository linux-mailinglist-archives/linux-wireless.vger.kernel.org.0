Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016463FAB24
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Aug 2021 13:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbhH2LlY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Aug 2021 07:41:24 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:13904 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235182AbhH2LlX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Aug 2021 07:41:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630237231; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=+ikE8RNXTwG+UIcBpFIUF3Wvhaay8G/x0xqbx3cp6xc=; b=ryTIDJ89HN9TOwTnO63SlQz2X6TYc8MQTkRxs9+pZl/vGiupWyniYOAuVE+J5VBdY4YpnGuR
 Heen7IdvFNtB/hi249f0VdPx407vsvN9g6ImWFOwuJ8pT1E7DPZgYN90aozalLYrxru9s7AK
 zcuhgEHOdiOdmW4TmR4jr9tUS6s=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 612b722b825e13c54a338de8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 29 Aug 2021 11:40:27
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 14B1CC43460; Sun, 29 Aug 2021 11:40:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1C09DC4338F;
        Sun, 29 Aug 2021 11:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 1C09DC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <timlee@realtek.com>, <kevin_yang@realtek.com>
Subject: Re: [PATCH 3/4] rtw88: support adaptivity for ETSI/JP DFS region
References: <20210802063140.25670-1-pkshih@realtek.com>
        <20210802063140.25670-4-pkshih@realtek.com>
Date:   Sun, 29 Aug 2021 14:40:12 +0300
In-Reply-To: <20210802063140.25670-4-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Mon, 2 Aug 2021 14:31:39 +0800")
Message-ID: <87ilzo4gyr.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
>
> Add Energy Detected CCA (EDCCA) mechanism to detect energy on the channel.
> And EDCCA support adaptivity mode now. From MIC Ordinance Regulating Radio
> Equipment article 49.20, ETSI EN-300-328 and EN-301-893, the device should
> be able to dynamically pause TX activity when energy detected on the air.
> According to ETSI/JP DFS region, driver will set corresponding threshold
> and stop TX activity if the detected energy exceeds the threshold. For now,
> we support it on 8822b and 8822c first.
>
> By default, EDCCA mechanism is turned on. For ETSI/JP DFS region, it will
> turn to adaptivity mode. However, with adaptivity, if environment is too
> nosiy, TX may often be halted. So, a debugfs for EDCCA is added. It can
> show what EDCCA mode is used currently. And EDCCA mechanism can be turned
> on/off through the debugfs while debugging.
>
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

> +static ssize_t rtw_debugfs_set_edcca_enable(struct file *filp,
> +					    const char __user *buffer,
> +					    size_t count, loff_t *loff)
> +{
> +	struct seq_file *seqpriv = (struct seq_file *)filp->private_data;
> +	struct rtw_debugfs_priv *debugfs_priv = seqpriv->private;
> +	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
> +	bool input;
> +	int err;
> +
> +	err = kstrtobool_from_user(buffer, count, &input);
> +	if (err)
> +		return err;
> +
> +	rtw_edcca_enabled = input;
> +	rtw_phy_adaptivity_set_mode(rtwdev);
> +
> +	return count;
> +}
> +
> +static int rtw_debugfs_get_edcca_enable(struct seq_file *m, void *v)
> +{
> +	struct rtw_debugfs_priv *debugfs_priv = m->private;
> +	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
> +	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
> +
> +	seq_printf(m, "EDCCA %s: EDCCA mode %d\n",
> +		   rtw_edcca_enabled ? "enabled" : "disabled",
> +		   dm_info->edcca_mode);
> +	return 0;
> +}

[...]

> --- a/drivers/net/wireless/realtek/rtw88/main.c
> +++ b/drivers/net/wireless/realtek/rtw88/main.c
> @@ -23,6 +23,7 @@ EXPORT_SYMBOL(rtw_disable_lps_deep_mode);
>  bool rtw_bf_support = true;
>  unsigned int rtw_debug_mask;
>  EXPORT_SYMBOL(rtw_debug_mask);
> +bool rtw_edcca_enabled = true;

You are making rtw_edcca_enabled per driver, should it instead be per
device? If something is changed via debugfs the assumption is that the
value is per device.

For example, let's say you have two rtw88 devices attached on the same
system, device A and B. If a user changes edcca via debugfs on device A
it will also change the state in device B. Is that the desired
functionality? If yes, I think you should add a comment to
rtw_edcca_enabled explaining that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
