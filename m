Return-Path: <linux-wireless+bounces-4388-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 735808725B4
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 18:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014F42834D3
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 17:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334EC168DD;
	Tue,  5 Mar 2024 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="2470CFr6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8285517582
	for <linux-wireless@vger.kernel.org>; Tue,  5 Mar 2024 17:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709659946; cv=none; b=DLkcrdZicuwoped8C2pA0jZT6bFQhxdiyTeFfv6qx8Si2qPPtPJpWE/rpvDa8LvQozC27Z/ksG2VQQxkg+uWbjfrgS9F7w0dEtoyadqYJ2p4TZoDHunyK4puWwKh135P8uS5xPY/5e6vPl6AIR4m4Bcv6RkIKIj44oqirsQjn1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709659946; c=relaxed/simple;
	bh=hC5W6SzlyKm142rCF/Gy9ny1G5NmzizAsB/pB1Y31pM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hQGM9tU0X5d//bC9Q6vAoaKwcZ/9yxrzMGxCaHeHqO5Bwl3HYBLnaVO23LAB8cMa2Wlmzy2Z2j/f21mmtHuQMPtsm42qw+2d4bNR94x1a8xm1SbVuggusDs1rrFlKY9HMUUPUVW8gw0mK/vO1jD/0CZ4rXacAzt+rf6/newtenY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=2470CFr6; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d568fbf62so3208950f8f.3
        for <linux-wireless@vger.kernel.org>; Tue, 05 Mar 2024 09:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1709659942; x=1710264742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RHGCjxaUPDbJWBPK3hLyM4vR5pB66bSx5oKjgwP2aPM=;
        b=2470CFr6JxK8r7Jh7TD5XziY4hGGCBNT8RAi/8gsR+jtbmXik5etSUGe4+8lm1ybVe
         rDZP42yaa5FmINifWGQuNbtgTRIuL0WmYf+Eg7TFtAjSBWY+DzZLwjLirjfYCBnu8bCR
         L09uD6CtLstxyH87sZpQ/ErsSj+jqQ44iAYqkszI0z2aL7PSwfmGkLo881J6kFDrXNyW
         Jgw75eQoHJPNZEl0Ar6t6tmfCsFxVRjDlNf/0gi+7ZbJpPYKPHlHgJk/6RJltFe2/PNs
         f3/cHn4Aq6PFCZVHIsKcJPOTnXYjXuimOh8Z/kGJ6Dx2TABhetsOQeBNo0uxbGEuoUCq
         VkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709659942; x=1710264742;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RHGCjxaUPDbJWBPK3hLyM4vR5pB66bSx5oKjgwP2aPM=;
        b=eTNGqmhUaOBx84LqWt4aywwzF4yBvRau8McSITje6ztU8HI5ENtuBueXA5bGJP9G7L
         UlnjqX4reI10gHwZ9XehSF8DTvlWlz7b+9gJUAXazClJj4oso7h0hMBtSw4cw9fkfOBn
         Bsk8zYKag4NyRFp16rjEbnt+WKdA5e0QK3YZqp6s/D8QsJOXzdNQX9/niRuq8oQ4bLnB
         f4jKivhBbapgdUsJDuiFZxeDTdnrsDllpLuQwZZWI24ZFGOzskGVm+kdvv555kTtx86k
         ZKKB9/+uuI89JBX3c9HVYl0Qbj/Orjg4aabDXt1rFDqqSiDAiIZlZV/8XoLnrDh5/Y4I
         f7PA==
X-Forwarded-Encrypted: i=1; AJvYcCVqri9noKETMJ03EunHkOW2H0NBtjgwxYSiSEhwudupGj87XCmukA6vLTQTrnSxpByE97Idpbbli8OW1QR1uzjEBfXIZGwQUSjbOG2ejRA=
X-Gm-Message-State: AOJu0YzcgKIXV9JN1as6B0juEpst8loOklqvk1hGSWyXRwCzJINSKdye
	I9JsrhKZ/31xcT7qMmEhhzTt9oGZFmHd3QdJaGUH9AkjOaScDkTcALSad25qCGg=
X-Google-Smtp-Source: AGHT+IFUWWu6brcU5Z3h34Cf83caanSuxe11qXyds41BJD+kSKbWTuLmI4UzT/Lk46RQ0AtgdDlaRw==
X-Received: by 2002:a5d:4f07:0:b0:33e:11c3:7ebf with SMTP id c7-20020a5d4f07000000b0033e11c37ebfmr9315331wru.62.1709659941681;
        Tue, 05 Mar 2024 09:32:21 -0800 (PST)
Received: from [192.168.108.81] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id q16-20020a5d6590000000b0033d56aa4f45sm15484527wru.112.2024.03.05.09.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 09:32:21 -0800 (PST)
Message-ID: <0816f7bb-3c97-4b90-8e19-191552ea6e26@freebox.fr>
Date: Tue, 5 Mar 2024 18:32:20 +0100
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
 <6d4b1381-c121-4cda-a8c9-9ccac56bd447@freebox.fr> <87plw87nsc.fsf@kernel.org>
From: Marc Gonzalez <mgonzalez@freebox.fr>
In-Reply-To: <87plw87nsc.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/03/2024 15:31, Kalle Valo wrote:

> Thanks, this is exactly what I'm proposing.

With your suggestions, the patch becomes much simpler:

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 0032f8aa892ff..18d0abcf6f693 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -769,6 +769,7 @@ static const char *const ath10k_core_fw_feature_str[] = {
 	[ATH10K_FW_FEATURE_SINGLE_CHAN_INFO_PER_CHANNEL] = "single-chan-info-per-channel",
 	[ATH10K_FW_FEATURE_PEER_FIXED_RATE] = "peer-fixed-rate",
 	[ATH10K_FW_FEATURE_IRAM_RECOVERY] = "iram-recovery",
+	[ATH10K_FW_FEATURE_NO_MSA_READY] = "no-msa-ready",
 };
 
 static unsigned int ath10k_core_get_fw_feature_str(char *buf,
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index c110d15528bd0..1ac8ea02cc088 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -835,6 +835,9 @@ enum ath10k_fw_features {
 	/* Firmware support IRAM recovery */
 	ATH10K_FW_FEATURE_IRAM_RECOVERY = 22,
 
+	/* Firmware does not send MSA_READY indicator */
+	ATH10K_FW_FEATURE_NO_MSA_READY = 23,
+
 	/* keep last */
 	ATH10K_FW_FEATURE_COUNT,
 };
diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
index 38e939f572a9e..7e408fd63cdb8 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.c
+++ b/drivers/net/wireless/ath/ath10k/qmi.c
@@ -1040,6 +1040,8 @@ static void ath10k_qmi_driver_event_work(struct work_struct *work)
 		switch (event->type) {
 		case ATH10K_QMI_EVENT_SERVER_ARRIVE:
 			ath10k_qmi_event_server_arrive(qmi);
+			if (test_bit(ATH10K_FW_FEATURE_NO_MSA_READY, ar->running_fw->fw_file.fw_features))
+				ath10k_qmi_event_msa_ready(qmi);
 			break;
 		case ATH10K_QMI_EVENT_SERVER_EXIT:
 			ath10k_qmi_event_server_exit(qmi);



I need to build a kernel + rootfs + FW to test the proposed solution,
then I can spin a formal submission.

(I didn't understand why this patch requires Dmitry's series?)

Do I need to submit a symmetric patch to linux-firmware to define bit 23?
And also a patch to add the bit to some firmwares? (All msm8998 FWs?)

Regards


