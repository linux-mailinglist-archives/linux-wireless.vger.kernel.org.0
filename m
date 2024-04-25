Return-Path: <linux-wireless+bounces-6847-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 081F78B20AF
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 13:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B367628950A
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 11:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37ED512AADC;
	Thu, 25 Apr 2024 11:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="dTyOCpXn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB058526B
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714045735; cv=none; b=DucrsG5RmHUvmQ9Kr4kBfR7tQxPL2N+XaG2LpalkF5d5jTGhfinPhjNJU5JGdPQF/gUW/OshLUoRDPs7uXzPypv2rBm6FG/d6tnv3gbj76sogyOvqgTAWXeY0Cn25aTSI5pCoH4Nuh15Jq23u4SPDQpRwXTyZY99EDPWKC9JbFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714045735; c=relaxed/simple;
	bh=iRqZJGzbLO7immaT4nudfgfXnI3zAGjQPmg5oNwp8Jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHWyCDqYf66YJkdF3iBWWZyXOva19W+bTZRupCxdp8RwkFLeqWrLYyApzv1NOkrvf7G0w5m1YypfS/uaeyj0ArV069YU6+L+/y1dANOB3kwu+AVcUoxokvsylMahw6pwmn4mSnEbdSrmpiG375FfjAZiIsWZslqh+dwreTQmpQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=dTyOCpXn; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34b3374ae22so860823f8f.0
        for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 04:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1714045732; x=1714650532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HaiwvUlPF7WAHLG6FS4I2jCzZYZaAZS8Db4/cIEwfh4=;
        b=dTyOCpXnj5OIawdlvw+4hKKvxtK2Lv8kA3qTHHWaPQ2ygYnudRZ2Smpo0El6KIIndF
         24nVoGpAVJoOZRs9rloecX4UyAJzDmzRIIXH4FEIqrDuLkQ2QJJi+MqxszhiyjcKFm/0
         doX/WjCWimogxslA8Ba+wjKTmbP76ZV9kn0F70ur+AILRDzGS+9b8Yq25WBRLeoHVWfx
         wWXMgkCDbi80LSrRH2Ee48jPkL+81GR6J0MAR5oQ+mapHGQUFbPCgVTEv1SNz4IDmamf
         8ynCc/K0KRWfgwyuEoW1KrNFv2LEX7TR/8E3B3M7fkQzqoFBvfZxwalrWMwW/Kabj5lN
         IkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714045732; x=1714650532;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HaiwvUlPF7WAHLG6FS4I2jCzZYZaAZS8Db4/cIEwfh4=;
        b=Ku878K+rb/nsDmB8UncHaOm4v7rh1Q5rPDIuXXvnoLHoNQKDzmfD8ZA522WzmAZqkM
         aSYMzuwVYhoSr9AFhwelJk1vzGBhA5lgwligwX/dIZkOo//pMgnt/mBPAKsfa6Ay5XaV
         wjMOwlKWt2Yfn7N81kbaE76JacnZFFVh0aIZlnNVZhYYegGnaf3VvEeBL/fkOEQMhEAd
         DsXjdCabmths/yAS5MR+xgzsjp3lmuxqVBftBDyY4VQLVaO/RhFt+SM3fI/pOi1LxQhL
         27mH87blBxfAbmGcLwlK6hhUYQDRd9Zbv8V4fhlPgISU7uIOCfqupUNXYQVNLruELV/X
         MGCA==
X-Forwarded-Encrypted: i=1; AJvYcCXOnMUSWDgYV0lT8Ftp7x4RdD01A9i9vUBNoJXcM6msINQg+fyCQO9wV5CwVpPEwO8Rl5/0eYpKc4kFhYpclcgmlz3xPiAKA3NSKfIHcsA=
X-Gm-Message-State: AOJu0YwvgDSPTlC0e+frSyxn7VJOHLUmyQEGmcLSuz2Chj/X6Kmf55ID
	/Hwx2v6QCaGeTPFOA7mMgd4STkD14LuUxKsGRNN1PFMaImfS9+h58xA0j4RSg8w=
X-Google-Smtp-Source: AGHT+IEQKdEXXjmwHYjGtrZx+A4ntpBLtbov3wrDvOhIJp7CrXwZrZ9Zsbj80j2w2j8dI4s5T//PLA==
X-Received: by 2002:a05:6000:12c3:b0:34a:d130:611b with SMTP id l3-20020a05600012c300b0034ad130611bmr4607478wrx.17.1714045731749;
        Thu, 25 Apr 2024 04:48:51 -0700 (PDT)
Received: from [192.168.108.81] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id p17-20020a5d4591000000b0034658db39d7sm19844255wrq.8.2024.04.25.04.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 04:48:51 -0700 (PDT)
Message-ID: <de65290c-0f67-4499-ba28-a460e6d6e419@freebox.fr>
Date: Thu, 25 Apr 2024 13:48:50 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: msm8998: set
 qcom,no-msa-ready-indicator for wifi
To: Kalle Valo <kvalo@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>, ath10k
 <ath10k@lists.infradead.org>, wireless <linux-wireless@vger.kernel.org>,
 DT <devicetree@vger.kernel.org>, MSM <linux-arm-msm@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Pierre-Hugues Husson <phhusson@freebox.fr>, Arnaud Vrac <avrac@freebox.fr>,
 Bjorn Andersson <andersson@kernel.org>,
 Jami Kettunen <jamipkettunen@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
References: <fd26ce4a-a9f3-4ada-8d46-ed36fb2456ca@freebox.fr>
 <5cdad89c-282a-4df5-a286-b8404bc4dd81@freebox.fr>
 <252618e8-9e80-4774-a96c-caa7f838ef01@linaro.org>
 <502322f1-4f66-4922-bc4e-46bacac23410@linaro.org>
 <0ca1221b-b707-450f-877d-ca07a601624d@freebox.fr>
 <CAA8EJppeREj-0g9oGCzzKx5ywhg1mgmJR1q8yvXKN7N45do1Xg@mail.gmail.com>
 <87ttkh49xi.fsf@kernel.org> <e804b257-4dc0-45f1-a5c5-66bda51cf296@freebox.fr>
 <87h6gh406w.fsf@kernel.org> <ad5e178b-cd64-4a87-8994-f917993f3bbb@freebox.fr>
 <871q6tu6bn.fsf@kernel.org>
Content-Language: en-US
From: Marc Gonzalez <mgonzalez@freebox.fr>
In-Reply-To: <871q6tu6bn.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/04/2024 11:42, Kalle Valo wrote:

> Marc Gonzalez wrote:
> 
>> Do you prefer:
>>
>> Option A = never waiting for the MSA_READY indicator for ANYONE
>> Option B = not waiting for the MSA_READY indicator when
>> qcom,no-msa-ready-indicator is defined
>> Option C = not waiting for the MSA_READY indicator for certain
>> platforms (based on root compatible)
>> Option D = some other solution not yet discussed
> 
> After firmware-N.bin solution didn't work (sorry about that!) my
> preference is option B.

Actually, Option B is this patch series.
Could you formally review it?

Perhaps one thing I could do slightly differently is to NOT call
ath10k_qmi_event_msa_ready() a second time if we DO receive the
indicator later.


>> Dmitry has tested Option A on 5 platforms, where it does not induce regressions.
>> I worked on msm8998, where Option A (or any equivalent) unbreaks WiFi.
> 
> What do you mean here? Are you saying that option A works on all
> devices? I'm guessing I'm misunderstanding something.

No one serious would ever claim "this works on all devices".

Dmitry and I tested the following patch:

diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
index 38e939f572a9e..fd9ac9717488a 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.c
+++ b/drivers/net/wireless/ath/ath10k/qmi.c
@@ -1040,6 +1040,8 @@ static void ath10k_qmi_driver_event_work(struct work_struct *work)
                switch (event->type) {
                case ATH10K_QMI_EVENT_SERVER_ARRIVE:
                        ath10k_qmi_event_server_arrive(qmi);
+                       printk(KERN_NOTICE "NOT WAITING FOR MSA_READY INDICATOR");
+                       ath10k_qmi_event_msa_ready(qmi);
                        break;
                case ATH10K_QMI_EVENT_SERVER_EXIT:
                        ath10k_qmi_event_server_exit(qmi);
@@ -1048,7 +1050,7 @@ static void ath10k_qmi_driver_event_work(struct work_struct *work)
                        ath10k_qmi_event_fw_ready_ind(qmi);
                        break;
                case ATH10K_QMI_EVENT_MSA_READY_IND:
-                       ath10k_qmi_event_msa_ready(qmi);
+                       printk(KERN_NOTICE "IGNORING ACTUAL MSA_READY INDICATOR");
                        break;
                default:
                        ath10k_warn(ar, "invalid event type: %d", event->type);


Dmitry tested several platforms:

> For reference, I tested this patch on sdm845 (db845c), qcm2290 aka
> qrb2210 (rb1), sm6115 aka qrb4210 (rb2) and sm8150 platforms.
> I was not able to fully test it on sda660, modem crashes without this
> patch (there is no MSA_READY indication) and with the patch applied
> the device hangs, most likely because of the IOMMU or clocking issue.

I tested on apq8098 (msm8998 sibling).
Patch makes adapter work on my msm8998 platform.

Regards


