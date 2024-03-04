Return-Path: <linux-wireless+bounces-4341-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97842870638
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 16:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7A328164D
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 15:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1D5487B0;
	Mon,  4 Mar 2024 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="unmXPMir"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F9447772
	for <linux-wireless@vger.kernel.org>; Mon,  4 Mar 2024 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709567503; cv=none; b=Z5GK6FHo8dbK8eu7M/+E8n/hswCuDl3+hOlXYKxhmhHd1hC2zhNz2sR0pczsM/784hMt2dT56x9Wd+rO6xXq1pX/reT2S5+ZcatM/Wud8Bw5BFJDFSXlEwI/ROvbByE0eM1JdwAdi14bZF0rD9+DGmEvwEEShz7lpylzkfDGtuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709567503; c=relaxed/simple;
	bh=kdZve0sL9jBwyg4TW/Vv2hHeFdtOmfRmPAGzVwar+yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LuorLJGJ/0s+bKdFFwA97iD2unBUg8ry90X01fqxMars86mZzrSztM8BpiteGl1JIJeVn9S+UJdvS5DOrxGY43MfhMNZIleRFMKI9IwuCw3tUTVlREDrHqXK0z6ig+HAx7rbDL9SG3fpe6Uen8qii6vic6GqH17B/Oe+jzL3sH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=unmXPMir; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d38c9ca5bso2326236f8f.2
        for <linux-wireless@vger.kernel.org>; Mon, 04 Mar 2024 07:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1709567498; x=1710172298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IUb/5Oupvxe0SuRsceM3xY4GgJJePH6d2omdHhOHGS8=;
        b=unmXPMiruHGIP687IlVqrPaXoxyBoSog9WsS5s7cMcydGC4PVQHSTe/SS7GgifbnkW
         Tq8X3vGhYz95T4GFL87cHCAcj9RL1hzRDdNYHsuNVVXWC9bhI4W9vX5EPFch1STPdCFk
         DSv+bcKOUVQS4zXlrtwRadwOzO8LNRljDu7TK3cvkqogp0s24P6p3af7tEPzdElr1wNw
         j+K6+hrasW+k+GvRuwu67Qe5eaZVkgS8+7DA15s9BfXX5c8Bvyf07Axo9ySL2WQOt3je
         7oNX1qCDVoNArRs65QIjroFi/FSrHYj0f7wTn2VN8UHAoxAaSRS8Vu3Y3TZ1oR9t0uMz
         hHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709567498; x=1710172298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUb/5Oupvxe0SuRsceM3xY4GgJJePH6d2omdHhOHGS8=;
        b=erHxaYfOI+e35OqaHmD5U7/PFMPpAQi9L8iSjZuXirsPaQXMY6jfSWGDN1xGYKME1R
         MPTv7YBQWR8S+QOfnTQcIuhmlnKuquzRd1QlmUSpUWuAPXyKES8xJCWZDp+Ws6lcsXWS
         yoUCcRRbAuwGA62sH4g1tu584QJLem2PnQlrq/IvIplIMBfBMB2uFZAy2nKsQSMN3rfi
         1udUXJNlCSxqRYcCPRgWO5kJyxFn/3DOfNwz/rewldj9X5HCof9sRvvdwRazlrJrU4X4
         WTiAQio9C8F0LNQJH9li7JmoI/Q+s4p59OIv3nhG3/L5aozmZfuxyfIfFD/iAodXB8hf
         vClA==
X-Forwarded-Encrypted: i=1; AJvYcCV1ObXWHooL18mPqT90u9QoG0Lo4igKrd25OYgLQsf0JGrUwwacOLhrlJHQJ+13DGXiUbMDpCI3iiOVj8DXQJJoWZ+t+E6UlmOiLsAA2VA=
X-Gm-Message-State: AOJu0YytGNi+pUbEv8VwrhgCJU8VAADtTgfImTWsomHIZqWnMYGnfQRI
	67jtiMVglvogLU5+Yb8NScz8qu14ZzF4NGX5AKCMgW8FgEjsW5Km/jrITauG8cv2X5Ht0ZwvtHo
	e
X-Google-Smtp-Source: AGHT+IHqeWxijSP3Z1JMmmpZW/+BOmf4YxhMIFDWJw0VvSavoo6l4GTlTDqOtaWvfv49THeLaj4ykQ==
X-Received: by 2002:adf:ec43:0:b0:33e:3d75:b6bc with SMTP id w3-20020adfec43000000b0033e3d75b6bcmr2171129wrn.58.1709567498520;
        Mon, 04 Mar 2024 07:51:38 -0800 (PST)
Received: from [192.168.108.81] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id m26-20020a05600c3b1a00b00412cbe4f41bsm10118812wms.4.2024.03.04.07.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 07:51:38 -0800 (PST)
Message-ID: <6d4b1381-c121-4cda-a8c9-9ccac56bd447@freebox.fr>
Date: Mon, 4 Mar 2024 16:51:37 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
 ath10k <ath10k@lists.infradead.org>,
 wireless <linux-wireless@vger.kernel.org>, DT <devicetree@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Pierre-Hugues Husson <phhusson@freebox.fr>,
 Jami Kettunen <jamipkettunen@gmail.com>,
 Jeffrey Hugo <quic_jhugo@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
 <b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr> <871q8wk7o3.fsf@kernel.org>
 <3392f356-7b19-483d-b9f8-3bd84068fa52@freebox.fr> <87wmqoilzf.fsf@kernel.org>
 <c58e67e6-6a7f-4963-86b9-580165bf05ba@freebox.fr> <87cyse8j9m.fsf@kernel.org>
From: Marc Gonzalez <mgonzalez@freebox.fr>
In-Reply-To: <87cyse8j9m.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/03/2024 09:10, Kalle Valo wrote:

> Marc Gonzalez wrote:
> 
>> Kalle Valo wrote:
>> 
>>> Here's one example where in ath10k we use a feature bit as a workaround:
>>>
>>> 	/* Don't trust error code from otp.bin */
>>> 	ATH10K_FW_FEATURE_IGNORE_OTP_RESULT = 7,
>>>
>>>         ....
>>>
>>> 	if (!(skip_otp || test_bit(ATH10K_FW_FEATURE_IGNORE_OTP_RESULT,
>>> 				   ar->running_fw->fw_file.fw_features)) &&
>>> 	    result != 0) {
>>> 		ath10k_err(ar, "otp calibration failed: %d", result);
>>> 		return -EINVAL;
>>> 	}
>>>
>>> BTW for modifying firmware-N.bin files we have a script here:
>>>
>>> https://github.com/qca/qca-swiss-army-knife/blob/master/tools/scripts/ath10k/ath10k-fwencoder
>>
>> If I understand correctly, you are saying that there is
>> (maybe... probably) a bug in the FW, so it makes sense to
>> tag that specific FW file with a special bit which the kernel
>> will interpret as "this FW is broken in a specific way;
>> and here's how to work around the issue."
>>
>> So this bit would serve the same purpose as my proposed
>> "qcom,no-msa-ready-indicator" bit (that bit existed instead
>> in my board's device tree).
>>
>> The problem I see is that the firmware files are signed.
>> Thus, changing a single bit breaks the verification...
>> UNLESS the FW format allows for a signed section ALONG-SIDE
>> an unsigned section?
> 
> firmware-N.bin is ath10k specific container file format and we (the
> Linux community) have full access to it using ath10k-fwencoder, there's
> no signing or anything like that. One of the major reasons why it was
> designed was to handle differences between firmware branches, just like
> in this case.
> 
> Of course plan A should be to fix the firmware but if that doesn't work
> out then plan B could be using the feature bit in firmware-N.bin.
> 
> BTW related to this Dmitry is extending firmware-N.bin handling for
> WCN3990, you will most likely need to use that:
> 
> https://patchwork.kernel.org/project/linux-wireless/cover/20240130-wcn3990-firmware-path-v1-0-826b93202964@linaro.org/


If I understand correctly (happy to have anyone correct any
misunderstandings), if the FW cannot be fixed (for any reason),
then we would have to do something like this:


diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 0032f8aa892ff..c8778ebe922af 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -769,6 +769,7 @@ static const char *const ath10k_core_fw_feature_str[] = {
 	[ATH10K_FW_FEATURE_SINGLE_CHAN_INFO_PER_CHANNEL] = "single-chan-info-per-channel",
 	[ATH10K_FW_FEATURE_PEER_FIXED_RATE] = "peer-fixed-rate",
 	[ATH10K_FW_FEATURE_IRAM_RECOVERY] = "iram-recovery",
+	[ATH10K_FW_FEATURE_NO_MSA_READY] = "no-msa-ready-indicator",
 };
 
 static unsigned int ath10k_core_get_fw_feature_str(char *buf,
@@ -2941,6 +2942,9 @@ int ath10k_core_start(struct ath10k *ar, enum ath10k_firmware_mode mode,
 
 	ar->running_fw = fw;
 
+	if (test_bit(ATH10K_FW_FEATURE_NO_MSA_READY, fw->fw_file.fw_features))
+		ar->fake_msa_ready = true;
+
 	if (!test_bit(ATH10K_FW_FEATURE_NON_BMI,
 		      ar->running_fw->fw_file.fw_features)) {
 		ath10k_bmi_start(ar);
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index c110d15528bd0..ce71097b97a1d 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -835,6 +835,9 @@ enum ath10k_fw_features {
 	/* Firmware support IRAM recovery */
 	ATH10K_FW_FEATURE_IRAM_RECOVERY = 22,
 
+	/* Firware does not send MSA_READY indicator */
+	ATH10K_FW_FEATURE_NO_MSA_READY = 23,
+
 	/* keep last */
 	ATH10K_FW_FEATURE_COUNT,
 };
@@ -1151,6 +1154,9 @@ struct ath10k {
 	u8 cfg_tx_chainmask;
 	u8 cfg_rx_chainmask;
 
+	/* FW does not send MSA_READY indicator. Fake it */
+	bool fake_msa_ready; /* bool or u8? or s8? or bitfield? */
+
 	struct completion install_key_done;
 
 	int last_wmi_vdev_start_status;
diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
index 38e939f572a9e..0776e79b25f3a 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.c
+++ b/drivers/net/wireless/ath/ath10k/qmi.c
@@ -1040,6 +1040,8 @@ static void ath10k_qmi_driver_event_work(struct work_struct *work)
 		switch (event->type) {
 		case ATH10K_QMI_EVENT_SERVER_ARRIVE:
 			ath10k_qmi_event_server_arrive(qmi);
+			if (ar->fake_msa_ready)
+				ath10k_qmi_event_msa_ready(qmi);
 			break;
 		case ATH10K_QMI_EVENT_SERVER_EXIT:
 			ath10k_qmi_event_server_exit(qmi);


-- 
Regards


