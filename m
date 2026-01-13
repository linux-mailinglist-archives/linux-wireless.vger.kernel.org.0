Return-Path: <linux-wireless+bounces-30751-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD443D19E70
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 16:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4FFD0301B324
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 15:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842C0392C3A;
	Tue, 13 Jan 2026 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ue4R45nj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QjmX2p5U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D74F392B85
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318171; cv=none; b=Pf7vIRnsAGX80eElyERkax6KT0yq+TJFwFQmHuhwMvevj9Ytf2trdsO9w6BfEA+kByESntPfMrSR1Y2wHwNyxruT+96D4qKNXo/8mR4yGYZUkIRXpbS3v3w/5F05OI6Px7t0hEvF1QOIGGCyV1izYmJN9Rsj/hFk8lkYVPl+0SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318171; c=relaxed/simple;
	bh=reG659tu3R2pU4VPXe/dbDPxUQQmS5GV+VdV/c+RZOg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U00f1YEDOGqtpyjxDpgpOTPYwGTeLoclUDC9nTN1WomBJykvDiuQiy9Jo6a4gC1VIFU3tHzkxhQ3S1Ua2M7vY7k96Ti1xnA98l2FuK/0SG1JHGQg+knVtIOlR3CDiwBQjYUKMSMkG4yFoNQzIBMiMUI2l+59T3VzQFk3ka4NfRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ue4R45nj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QjmX2p5U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60DEjKZb4080708
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 15:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RVWFI4N4Hrfdkqnsqe45+OS049az27v3jGHn+1hL+ko=; b=Ue4R45njqdiFzoR7
	sL7dszXBNCH3KkhHyVcLfIPSFd+B1LRB+ERHx25GU5z6ic+DhsI6ls5d12UzuExU
	rXKHeOvQvtrw4pfvWpOinTO/1KpluRj3ade0ISdeiPdW5Js9eNMO2wd70g8WxlMg
	THDmusZKI5PMD9FsO64SpMRb9asyc6zhpV9a73AffziDiLFo3QnLd3dzsJFx3QEw
	2m8cc5teBs2LNvPxitedImokiK1xf0HSI8u0mD9PJ3rnaGW+oXXQCwOnNekXyAJN
	9GURivqXhOf64a9URx7CsDjlTQ82Q7tFleG8oLB0Zvr5hXT5bkrv3cdPdX636OjA
	bW6Irw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bnr3e85ct-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 15:29:29 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2b21d136010so2884173eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 07:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768318168; x=1768922968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVWFI4N4Hrfdkqnsqe45+OS049az27v3jGHn+1hL+ko=;
        b=QjmX2p5Uk7602otpjdB2377z6qdB3bmKajGwtLa/fpOo8K/aSggF+mEBi1GnIg3nkp
         9p7T0IbMzqw5pyhbGlKeEbz9qopQf5gbXTO4ytrE7rm/y7/DuuT6mDKlhYwHwWhZwLdG
         IFx/baMhLhtmUeTRFOKUUwoosCBabMW5xJqWKzMeSK8DhABtcu1yQqJ6LM/Ne3CfsSdq
         X2Ae6itGc8JVKUPgaNgpSgGPLnHc2AinYIWQwVajp9rWxyqdqoG5sdFqrtwgTyncLbjU
         u4Nv1wKN+Hewkq/vM/J26VFeqjM3J6mHelQAc4Oe6i7UBYkaATPWSpeKmSW1VvckXV4Q
         xTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768318168; x=1768922968;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RVWFI4N4Hrfdkqnsqe45+OS049az27v3jGHn+1hL+ko=;
        b=KoOWicusMr9TKaWRZgwaEEx9sZEAdmzjVYukMi8zRmMqpLVnIVvqU080bAYK6MddwQ
         L7/8/AjvpFZ1lM6bzEhMpVBlji1q+w0Z5v8O3WQx3o6yd+5TTetFVzDsS1JlVs2RdZBg
         M0XNSk1gLryMlb/4Y7RjQw4GQV45sDQ5NfhAdia857sYz2oHIJ4vheJDGfoqg7COeYN6
         Nc9ycFJwlpC68btABKteuk+X443sGFvC8cR2IZ+HMmhXh5owgpJzUryZHa4XLJeGLH40
         NhiOfJngXDkywaVcIGzAnF7alIz999D5nEJ2NH5llZbMzN98nr5UDjsNocIdoSihxXhg
         MG1w==
X-Gm-Message-State: AOJu0YwIhDc+gtoZmpXTpU9YWWVt/g0PEw3ukIerQVfd3fqt/bnuWUCX
	tEicKxdls14DRrjW2SxiyKmrDoko1ZdDlpW3sRL1BqBhO+i1xDWg24paiAc0JukIl3bdGWmfLLt
	FPU4kfKGFq7FGCgeWGIYgf55MXY9/JpM+2foD86EHvaRlJkS/rtwJ7zGHkL28jMZps52fMg==
X-Gm-Gg: AY/fxX7XzYkAHVgUNo11RUUeIzSDa1cSD47bhNKSGypNAwnvW4HOTkjfPTM8O/GypXR
	URVTtt2MbqDSQo7zyUFQcTNnxtOap9CLI/dzAXxusyMKtYfJAInVNRdT5Gtu3p5O3hgbLyie7C+
	LAh/kdjqJnRml+oWy6aLx2cJs9vGIQBD2lYheA2upww1GeoUBrnUXYTAkzxcepmCTMzJVnsqDbE
	cw/HFVzm3Y5o+axUgQge815Wlv5mkjl24AwFRlZX0gnyKpk1A19g9izj3LRT0k8K5OMCD2TniTg
	N8P5wq9YzgSz0WaSijesF1icIryDCQrNz22hKlTRyJDn0c/U5cR5TDK2e6K3zx5t1xZdcIS/2l/
	jixoZbcwVTgOriipG9NvfetRSX1raGZjpjhk9CDcJ49p8VKF3Tlkamz0HA5ToVRSY
X-Received: by 2002:a05:7300:d15:b0:2b4:6e2d:96d1 with SMTP id 5a478bee46e88-2b46e2d9c9emr1974818eec.25.1768318168141;
        Tue, 13 Jan 2026 07:29:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0l+KvTel1JR161uOtDNalT5bd3+WxXcmCVbfQ0boWnz4a5//h0pclME4j4r2qGnRTnOh/jg==
X-Received: by 2002:a05:7300:d15:b0:2b4:6e2d:96d1 with SMTP id 5a478bee46e88-2b46e2d9c9emr1974772eec.25.1768318167621;
        Tue, 13 Jan 2026 07:29:27 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707d76aasm16858049eec.33.2026.01.13.07.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 07:29:27 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
In-Reply-To: <20260113-ath12k-fix-dead-lock-while-flushing-v1-1-9713621f3a0f@oss.qualcomm.com>
References: <20260113-ath12k-fix-dead-lock-while-flushing-v1-1-9713621f3a0f@oss.qualcomm.com>
Subject: Re: [PATCH ath-current] wifi: ath12k: fix dead lock while flushing
 management frames
Message-Id: <176831816701.3453943.10000086069261177867.b4-ty@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 07:29:27 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=TPFIilla c=1 sm=1 tr=0 ts=696664d9 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=bB3gi7QyEn5T5f7HmwwA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDEyOSBTYWx0ZWRfX4ocFVszJNsSC
 VO4LnpkyUVzZy6DmBJmyO9W0ny9URjjo99of/Pvc5drhNvx1OD6LPVpGPaR5IwgNVJlv1idqNvQ
 lkYKdCWkbQ2Uy5FGr6fuyRAdxBf1l3n/MJlEnWHy/5jyX5ODz/uboU4pUKFfSLF2l6ZVzZsdigO
 Q/2ThOyGx40ROhGHi54X7zdMpge2m/oLB1zBwQ9whGgCOw4BBMNxXXW7vcx/BTemR7hiEiReznQ
 ZIQljfjR+Q5KcOdZaVeq/idY+tZ09MyIvT12tj94Mjg0Eld0U+VCLlUDO9Q1Jupeh2eigDd+95V
 YDwLIXWHllkRvfIrzHGXbuAhRDcNpq+Sn5HogF2glL+Z8A+yY/XKfP+PnfKgtzMHjpCZQyV1gH6
 uxLe0ugMEB9+3cqaLXhTGaxjXE7kMfVnFz1IA7tFNkivtH/+G1Q23CWJwPuOun7KYNSSCvxEpZe
 viWQMuXGAVXqrbgi79w==
X-Proofpoint-GUID: DDMRhWHgwG2CZ72T1XopSZpUEvIskZ7Y
X-Proofpoint-ORIG-GUID: DDMRhWHgwG2CZ72T1XopSZpUEvIskZ7Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130129


On Tue, 13 Jan 2026 09:48:11 +0800, Baochen Qiang wrote:
> Commit [1] converted the management transmission work item into a
> wiphy work. Since a wiphy work can only run under wiphy lock
> protection, a race condition happens in below scenario:
> 
> 1. a management frame is queued for transmission.
> 2. ath12k_mac_op_flush() gets called to flush pending frames associated
>    with the hardware (i.e, vif being NULL). Then in ath12k_mac_flush()
>    the process waits for the transmission done.
> 3. Since wiphy lock has been taken by the flush process, the transmission
>    work item has no chance to run, hence the dead lock.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix dead lock while flushing management frames
      commit: f88e9fc30a261d63946ddc6cc6a33405e6aa27c3

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


