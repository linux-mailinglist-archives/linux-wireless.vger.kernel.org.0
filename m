Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4FB306313
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jan 2021 19:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhA0SP3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jan 2021 13:15:29 -0500
Received: from m42-8.mailgun.net ([69.72.42.8]:52334 "EHLO m42-8.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232758AbhA0SPP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jan 2021 13:15:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611771289; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=WhuOmKVFHa3k/WZWZ6j7B7SJho9Di137vDufHGsKghk=; b=RnmWeLwwAa77sErbNOd14Did60WSKTRG43/LI5q8GoOE5j4xl/afmoipiyuCnzA/RmGvOCfe
 WJ2jrrEzzFtZrDPlGlB4/xGFY3bA9oki6uW0rXf2Aw2a+GFyL8MHXw7lokXAJyk+dj1qPtwK
 3RXBgkqA7lyeuDxrmND6kLinfLw=
X-Mailgun-Sending-Ip: 69.72.42.8
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6011ad7a6287154b875f6789 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 Jan 2021 18:14:18
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CCD4EC43461; Wed, 27 Jan 2021 18:14:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 08DB2C433CA;
        Wed, 27 Jan 2021 18:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 08DB2C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Venkateswara Naralasetty <vnaralas@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCHv2 2/2] ath11k: Add ap power save support
References: <1598257589-19091-1-git-send-email-vnaralas@codeaurora.org>
        <1598257589-19091-2-git-send-email-vnaralas@codeaurora.org>
        <87h7n28di7.fsf@codeaurora.org>
Date:   Wed, 27 Jan 2021 20:14:13 +0200
In-Reply-To: <87h7n28di7.fsf@codeaurora.org> (Kalle Valo's message of "Wed, 27
        Jan 2021 20:02:08 +0200")
Message-ID: <87czxq8cy2.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Venkateswara Naralasetty <vnaralas@codeaurora.org> writes:
>
>> AP power save where AP goes to power save mode when no stations associate
>> to it and come out of power save when any station associate to AP.
>>
>> This AP power save capability can be used to save power with the drawback
>> of reduced range or delayed discovery of the AP
>>
>> This patch also porvides user configuration to enable/disable
>> this feature using vendor command. This feature is disabled by default.
>>
>> Tested-on: IPQ8074 WLAN.HK.2.1.0.1-01228-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
>
> [...]
>
>> +static int ath11k_vendor_set_wifi_config(struct wiphy *wihpy,
>
> s/wihpy/wiphy/
>
>> +					 struct wireless_dev *wdev,
>> +					 const void *data,
>> +					 int data_len)
>> +{
>> +	struct ieee80211_vif *vif;
>> +	struct ath11k_vif *arvif;
>> +	struct ath11k *ar;
>> +	struct nlattr *tb[QCA_WLAN_VENDOR_ATTR_CONFIG_MAX + 1];
>> +	int ret = 0;
>> +
>> +	if (!wdev)
>> +		return -EINVAL;
>> +
>> +	vif = wdev_to_ieee80211_vif(wdev);
>> +	if (!vif)
>> +		return -EINVAL;
>> +
>> +	arvif = (struct ath11k_vif *)vif->drv_priv;
>> +	if (!arvif)
>> +		return -EINVAL;
>> +
>> +	ar = arvif->ar;
>> +
>> +	mutex_lock(&ar->conf_mutex);
>> +
>> +	ret = nla_parse(tb, QCA_WLAN_VENDOR_ATTR_CONFIG_MAX, data, data_len,
>> +			ath11k_vendor_set_wifi_config_policy, NULL);
>> +	if (ret) {
>> +		ath11k_warn(ar->ab, "invalid set wifi config policy attribute\n");
>> +		goto exit;
>> +	}
>> +
>> +	ar->ap_ps_enabled = nla_get_flag(tb[QCA_WLAN_VENDOR_ATTR_CONFIG_GTX]);
>> +	ret = ath11k_mac_ap_ps_recalc(ar);
>> +	if (ret) {
>> +		ath11k_warn(ar->ab, "failed to send ap ps ret %d\n", ret);
>> +		goto exit;
>> +	}
>> +
>> +exit:
>> +	mutex_unlock(&ar->conf_mutex);
>> +	return ret;
>> +}
>
> Something which I find awkward here is that this is per pdev (=all
> vdevs), even though the vendor command is per vif. So if you change the
> config on one vif, all other vifs will change as well. And there's no
> way to check if the state from user space as there's only a set command
> and no equivalent get command.

Actually the problem comes here:

+static struct wiphy_vendor_command ath11k_vendor_commands[] = {
+	{
+		.info.vendor_id = QCA_NL80211_VENDOR_ID,
+		.info.subcmd = QCA_NL80211_VENDOR_SUBCMD_SET_WIFI_CONFIGURATION,
+		.flags = WIPHY_VENDOR_CMD_NEED_WDEV |
+			WIPHY_VENDOR_CMD_NEED_RUNNING,
+		.doit = ath11k_vendor_set_wifi_config,
+		.policy = ath11k_vendor_set_wifi_config_policy,
+		.maxattr = QCA_WLAN_VENDOR_ATTR_CONFIG_MAX
+	}

If it's per pdev you shouldn't set WIPHY_VENDOR_CMD_NEED_WDEV.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
