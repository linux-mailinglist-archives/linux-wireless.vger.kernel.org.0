Return-Path: <linux-wireless+bounces-5872-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCED98987E2
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 14:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 923C02915EC
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 12:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF3A43AA4;
	Thu,  4 Apr 2024 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="UdPpvlmz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F87D4DA1F
	for <linux-wireless@vger.kernel.org>; Thu,  4 Apr 2024 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233846; cv=none; b=dLzJ1lZprNlQS9xNlYUECVIXa8NBylM2Q52og8SyB+uLbsfPc18zDPVBgU1Y9ECuWF1TEDzx20aGIiyYWEijJ8NJH7830x3dcIJplwiTpTe+/kAc85DSDSGr2uLPCbq5jzdfSX5mVIjWVmbHFFa7KeHAElo1sy4rxzynIjG3pEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233846; c=relaxed/simple;
	bh=f28NbA4ZuZA/fyXjKOiLtArFZfgGGB0391csJcl81uI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gY8wbSXTrjuDmzoyyNIRdjoSb3ssB3IIKPdWRB3Dq6MGKH7/5vibzsmJt8GypbydD4NbDPjiy9IccNIw8yROARuVyPZSrVZgLXkUpLWAnRM34Kz/7AlhCHhqemBjTi943WNHIPM59VTzaAe4i20NJIh+b9eaxqTOOMbMBdpdlys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=UdPpvlmz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-415515178ceso6948455e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 04 Apr 2024 05:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1712233841; x=1712838641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3+BMPQleoesnEmuZIKvnJIR9RrNyhXeocOmGMELh+Uw=;
        b=UdPpvlmzbkRG0OBRspo3R6mr9qaIOIjxZ3kgoE+5VEYXEL0mQgi2XxI7E2yA7sSkP9
         2It8Fbwdwvf3cwC6wQ36RsqylPkisJvFNs64yUQahiBxtGZODn0TjkEsicM0HdeqUmys
         PVF4DoUzvrwAAN/I7G3AnJ+vbXnNN1c7y0BIbSJfP+qOgmI5QaHcFW2Za1wHY2YHj9Y3
         okSQgifFnSEurZ441Nh9NBkFymOqlRA8iCOIl8IYMDE8ghZ83NLvo3vyjCO5kypkYfl2
         C3AakstAoqzTWK0ctR00oDwjj1eE7htJoeilH/H5eRXyxXHarWWzHf9fTAsMb4TcGWxm
         UOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712233841; x=1712838641;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+BMPQleoesnEmuZIKvnJIR9RrNyhXeocOmGMELh+Uw=;
        b=N4DdTvw1zlB/eZ790t4PbJRRrPrHiEK96jTa8pv2LdLofS1yQvJFNvX5ejacpcGR7N
         JSx5IxPGzJUStIM+Ppy51jxcWu8HUosjPMClXhTatpVv+naU5ZIAcHcRgYLmhStakJ7o
         JPcrDG3vyUBmlQ32tgyh3Ymdxg0kBAEtM6mFSKZ5oC6RZVL5WGOOJ5Rvh1p30WAK4HAr
         B0YPfPAbP5uCMZ0wUTQoaI12F38SENJ23cBz/Hed6q++eMqWeJnUWCGu5iiqxUANZHQQ
         9WQzgziLFT1ip05l4he/QCFD1lrWE/FzEjsgCtKVJ3/0yfTs2Zd85bIO1AtLxpZVe5wn
         W/qA==
X-Forwarded-Encrypted: i=1; AJvYcCVlWPaWkOq2zcketiQb38Z+IbaqjPExriyBeZKP/1BFsAUKJY7duDrgMUZvQ+WGGgCKFYZG8froBOpmX1ZqOKaNydrt5p52tfVqcvcLAUo=
X-Gm-Message-State: AOJu0Yx8bVHP2k4R/pl7HKdb93kz7DRl/qOWhffjzsFPd0LFMpgL0EjU
	WxCQdYUpD/8HfxyXe0wvqAOK2K/HkcoI0giIqhSWz0GBzpVcVzDOXxaFFJ+nEDU=
X-Google-Smtp-Source: AGHT+IEV9SRf3L1IqaNEnuhHOMN7UgW5DwSVakpA51/xjM2jO4fLk72OjgqTkeR4uvMKVXqT36uwBA==
X-Received: by 2002:a05:600c:3115:b0:416:1d2e:62f1 with SMTP id g21-20020a05600c311500b004161d2e62f1mr1874361wmo.5.1712233841414;
        Thu, 04 Apr 2024 05:30:41 -0700 (PDT)
Received: from [192.168.108.81] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id bg2-20020a05600c3c8200b004149530aa97sm2617799wmb.10.2024.04.04.05.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 05:30:41 -0700 (PDT)
Message-ID: <e804b257-4dc0-45f1-a5c5-66bda51cf296@freebox.fr>
Date: Thu, 4 Apr 2024 14:30:40 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: msm8998: set
 qcom,no-msa-ready-indicator for wifi
To: Kalle Valo <kvalo@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>, ath10k
 <ath10k@lists.infradead.org>, wireless <linux-wireless@vger.kernel.org>,
 DT <devicetree@vger.kernel.org>, MSM <linux-arm-msm@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Pierre-Hugues Husson <phhusson@freebox.fr>, Arnaud Vrac <avrac@freebox.fr>,
 Bjorn Andersson <andersson@kernel.org>,
 Jami Kettunen <jamipkettunen@gmail.com>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
References: <fd26ce4a-a9f3-4ada-8d46-ed36fb2456ca@freebox.fr>
 <5cdad89c-282a-4df5-a286-b8404bc4dd81@freebox.fr>
 <252618e8-9e80-4774-a96c-caa7f838ef01@linaro.org>
 <502322f1-4f66-4922-bc4e-46bacac23410@linaro.org>
 <0ca1221b-b707-450f-877d-ca07a601624d@freebox.fr>
 <CAA8EJppeREj-0g9oGCzzKx5ywhg1mgmJR1q8yvXKN7N45do1Xg@mail.gmail.com>
 <87ttkh49xi.fsf@kernel.org>
Content-Language: en-US
From: Marc Gonzalez <mgonzalez@freebox.fr>
In-Reply-To: <87ttkh49xi.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/04/2024 13:57, Kalle Valo wrote:

> Dmitry Baryshkov wrote:
> 
>> I'd say, we should take a step back and actually verify how this was
>> handled in the vendor kernel.
> 
> One comment related to this: usually vendor driver and firmware branches
> go "hand in hand", meaning that a version of driver supports only one
> specific firmware branch. And there can be a lot of branches. So even if
> one branch might have a check for something specific, there are no
> guarantees what the other N+1 branches do :/

The consequences and ramifications of the above comment are not clear to me.

Does this mean:
"It is pointless to analyze a given version (or even several versions)
of the vendor driver downstream, because there are exist a large number
of variations of the code." ?

And thus, "it is nonsensical to try to "align" the mainline driver to
"the" vendor driver, as there is no single "vendor driver"" ?

Thus, the following patch (or one functionally-equivalent) is not acceptable?

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



Regards


