Return-Path: <linux-wireless+bounces-28800-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D72C477B8
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 16:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF4218850EE
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 15:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1C6314D27;
	Mon, 10 Nov 2025 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bUVZEtY1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aRt0Mw5Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFECF18CBE1
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787651; cv=none; b=SX0lKsfClElFZP6o/UV7fYYZwLk2/LuDpvIvkQHWDWh+RkQOSXnhYdxu3KVZjvcs6Afdr4uT6ZbCyG66BlXCqM++jGogcYLzGHq7kBAduMrKuTH7lT2s+NZknfft+jxVzywU0rVIBLaSi1WxYXHuaeBX8oo5x+aWtb9sthQril0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787651; c=relaxed/simple;
	bh=PPmK1d9AYEWLxFCgt1MwazYIEZSFFBgnTDp8MLgLaK8=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=VTF+hEC3tWB8ZYaGTVgLZuC0Z3Wl7GVMAfaGY+sMGCvsej6h2yBYW/hLqalPeFkjMNdpTqP8EfxxuB6c37B8vbt+NaVAr9UGoaA21U3kMg6laodufq1Lal8E47Jyp22ZXI7ac+gKNt6Ud60EtFfOJmiBreFpAFP5t1f1qPf+skI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bUVZEtY1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aRt0Mw5Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AACMuAV3306789
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 15:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=In2CglKkJlw2CPFhnxlidR
	KLUnNM/dvL9E32nfiEsvc=; b=bUVZEtY144oYGi0W/MZCRu7JQPhU+Uq2uG3miC
	fjBRI1LmkUY86U+n9rrdcpI4UdmDaDTqmwkKLTE9dt0h/ruymIuz8gd2iq7Y2xaZ
	qC6LW7QRhM2FK7FXnpjIHXsuvGi8t7VyedlzXwQCpE7Rsn4PFXUDElxnG4ZRP6T+
	YXQFiIpZnVYGA0kLecCCnnVjoK90jnIo5D5Ne+qmWvgbLvC6Ph1xlCuP0WMI4zkm
	K9St+U2jr4reBs3f7pNkkAUhwzfn3vT3+1zacz1iEGghDuYgdf29hSrDEGR+UZsc
	0NRTEu0k1KSrQGFNbKbHK84bIVqlNWPf1P1bdNhhqhIAjeEw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abg0q8fp8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 15:14:08 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6097ca315bso7362003a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 07:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762787648; x=1763392448; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=In2CglKkJlw2CPFhnxlidRKLUnNM/dvL9E32nfiEsvc=;
        b=aRt0Mw5Zd96lXS6IXrKchGBh7eSL9b3e5T1W4iqfDMzUUIodrzDtspJTc2Jow4tOIc
         aCCKnayWNxTSg8USiRTPCihSqsdNQg+6A7nsMZcvs6WpbNZtLjsqoCJuF44rlIko84Vf
         G8rzGRQzK3tFXwwAskzGocJuqKvmn1mT1JYnTECw40y3e1mL6JvvasADlBbNi5cPv6Xt
         kWmLiEooU+GzKCDPDbdhehlaLknyre4axoEPyZI37sIYkphn2FbaU8jklfFxyiNak/b4
         Ln3qWCnGSjDYCFuf0BCxKVwaQIpVXusv6nDHLOB3jZDf3UgOBgQeEAIVfwykbvQ9s3eH
         UeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762787648; x=1763392448;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=In2CglKkJlw2CPFhnxlidRKLUnNM/dvL9E32nfiEsvc=;
        b=f8EaixWo3OTjYSYh1ULwTwbIUf6kr/jEGGJsfMtbLtU8cW87KBl1zYf7dkrIT+V5zY
         U6HGzdvLzaM/BQ53pDuJVNC1u0sC4m4fxbzxf/+3W6LvtI5pQBayKGDl34mSW23KOhXJ
         wDDU95DB81tq6LCoFKjnltLPThnv8PHDSz4Befk2pmO2sy5OmKtso4TIql3wEYi+vF4Q
         JeSQDRbgKw4EQD+ulFlC2dV+ByVl1ZC3PDfk8wvZp3KMEntmB2W0WnYqDgWHeI3XjVpB
         alTHK+dClRwgRB2N2g4POqhd5PnBBioJmoQ2Ece+bSBDBVQmH3DB8xfK36YOf1GD2C1+
         oN0w==
X-Gm-Message-State: AOJu0YyuZeDAIWFCC4wxqxlEyjpFtoV8nK23zVjSQqqpHfiY/DOUmpcr
	oJt4e6Nttza39E9iQAM3mn9nhBZyxJufI+jNnBeOX4lxMGu4mZ8Zh+y0BIwDEMbA1FcNK6XnFzu
	Sr7YHLArl3sMKkA74aJu/lD1KrrDDARRj/F0hSZWWM612mybdK8l0bP+KyZlTBtGMb4ACgZUgAq
	0fyg==
X-Gm-Gg: ASbGncvo+1SUST6OlhKHKweFgPZmWlnfzzofsTRZBKjGwEowuGSXI0RziHAJeiYI9Ta
	w9UKqnQRKwwEsSC1caHm0R37kFxL5QbMQ1cGf8th5MB+Z1ycJkGPoX9mSj0CaOoE90jpFz4NtXp
	0AUkn+4x7lMuR05SAH7atxLXX/RJBfOBT1GpeU2TS9RpjAE+MjC7HbuEmQGRF0NfdFfqGjQONDq
	LGPdFPcN1vEEkKO/jvGnKYyU44xUgHosnqKApAtP/ojZ3bWET6i//Vq8K+sBAxcBFJ5terHodig
	xmPUr0Bz/Mova3gc/YDrvkBLf0MIiZXPwglrpWQEoyIAC8A7u0h3HZG1CYBcxUymx/GLNXIoI80
	dWKpfYG4XFU+ZqsJQVBPxKuF/GhLo/MQo4a4=
X-Received: by 2002:a05:6a00:2da2:b0:7ae:fea:e928 with SMTP id d2e1a72fcca58-7b2266a4f3fmr11767581b3a.18.1762786854783;
        Mon, 10 Nov 2025 07:00:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTjgRCTxMSJ9PxX2gFFU5nHFuD65wVzXEp2yytUimmLc3aFvNbJN7pJ+c/AoWSO+a/QxJeUw==
X-Received: by 2002:a05:6a00:2da2:b0:7ae:fea:e928 with SMTP id d2e1a72fcca58-7b2266a4f3fmr11767447b3a.18.1762786853400;
        Mon, 10 Nov 2025 07:00:53 -0800 (PST)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9c09cd6sm12078801b3a.23.2025.11.10.07.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 07:00:53 -0800 (PST)
Message-ID: <b7bd9e01-ac73-4630-afe4-01dc57320b05@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 07:00:51 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Cc: ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        jjohnson@kernel.org
Subject: pull-request: ath-current-20251110
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=D6JK6/Rj c=1 sm=1 tr=0 ts=69120140 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=33HcGjt8BaiwP3wcfBYA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEzMSBTYWx0ZWRfX9pAZJTaeB7Cr
 Hi/zk6R263f6J7SQbTIoRzrl+/Mx7ykM+kHeLE05LvYVriANIEzrIOUqUp34tUIlPcWtK0iRCDI
 IN5lRyFE4OkPQ9ET3wV9t65hMfmRsV9cJugHPbGALbMrDjI/RvtjeTGxDoBIIM5dTrU6vPIu4TI
 8VHkoDC+1PPEopUF3DHGBWN50LQdUCa81yhlHIkntKnuleGj1X74LAMaTvDlYhiWnsiMtMFQdA9
 /FoM4Pa26p5DQlKZOZ9UPbimN+XsGV0AroF62KT8Bpk1BZ6qjMUXVK2ruvhtSHpJJR8Y2tWCD6V
 Zh+GCV70vZd5d7kn0ghhAhaQH395vtQGuxPk9+W3PdAV5GQWUs1GtFf+xTX0yD4K9rCYWP3Dy9L
 hEoVN40QHJCyBBdjHEveS5FXKhhakQ==
X-Proofpoint-GUID: ZhHELrU_yFfQNVsCTEMlBazyiDuDvgxe
X-Proofpoint-ORIG-GUID: ZhHELrU_yFfQNVsCTEMlBazyiDuDvgxe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100131

The following changes since commit 4c740c4d8bac5569c5bf5f86db65ce779178f9a2:

  Merge tag 'ath-current-20251103' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath (2025-11-05 16:18:48 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-current-20251110

for you to fetch changes up to 9065b968752334f972e0d48e50c4463a172fc2a7:

  wifi: ath11k: zero init info->status in wmi_process_mgmt_tx_comp() (2025-11-06 07:26:21 -0800)

----------------------------------------------------------------
ath.git update for v6.18-rc6

Fix an ath11k transmit status reporting issue. This issue has always
been present, but not reported until recently.

Bringing this through the current release since there is now a
userspace entity that wants to leverage this.

----------------------------------------------------------------
Nicolas Escande (1):
      wifi: ath11k: zero init info->status in wmi_process_mgmt_tx_comp()

 drivers/net/wireless/ath/ath11k/wmi.c | 3 +++
 1 file changed, 3 insertions(+)

