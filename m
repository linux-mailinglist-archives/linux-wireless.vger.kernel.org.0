Return-Path: <linux-wireless+bounces-29547-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7332ACA8670
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Dec 2025 17:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 195C830F3025
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Dec 2025 16:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08526312810;
	Fri,  5 Dec 2025 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AmewZFZu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jqegb3Xf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291EE313535
	for <linux-wireless@vger.kernel.org>; Fri,  5 Dec 2025 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764952218; cv=none; b=GA+UHozdNtNIeLX8gKh3P3qt+0hSqboOt6WsKJbMYqXH0k0YrvLgyJL3yJeGBQy0rknGdZJxAnIRe6sRL6ssYuD3w/4BjSGkcJIhMAzlPnwx1Gdc+wA5cd+ct4io6ilT4bL+RfkNFH7d7LnWNZv/QszqF/blfPHJDzTJmqFyiaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764952218; c=relaxed/simple;
	bh=1RH1+qqbjkHrUYlnfXTxT1ospjs33xMDkwAJRXvqUmk=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=WnAVGdb/KsmcmXSLW4gC28CO98KOWn7ge8IrriI7RzxnmnVnY0q3s082bUBuUIgyH2OgPPkVpwtdeSBk7gYqCYPWPXQykMML5T9Z4nYfydHq4aRAR5XV4gzvwXSRAugp8qBu8UKrrJpd+ySTKrJp4OhV2pqDtWtst2alyTuxqjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AmewZFZu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jqegb3Xf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5FBPe71028324
	for <linux-wireless@vger.kernel.org>; Fri, 5 Dec 2025 16:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=uY/zz/FmTheKinzMsruxPA
	eAFgeFSh6MXrbrP2Vw8Ck=; b=AmewZFZuTpnfOwXbHKGEFposUfJyFi+9L/sM1r
	dSP3z8QBY0s66WGN4QyK0LiJWmXsSTQKVNyoVvL4s1MnLL1Rhj7gRAT4lNs2nURK
	dXHXbwhxGEmkvjv8VHTbYeo1HDmUf46r0p770SoRRFiX5mGiFt+xObRaXGrpEgo/
	CnIpWfQmW+Sgv/N5Ch4PPntC5ALF1km241FZ0pnT1Mk+k1E3nLSOj1W54UjHiUhv
	6wxXjP38eeyJj3JO2sFOcSCJadq8QQECu5O9iFXzot9W7jffAsdqNyk0UiBmYzZh
	gqmSJhtxjEUoF3w2O17fdLobl4KIkCGudqsdbL45Ahy+TH2Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4auj7n2u7q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 05 Dec 2025 16:30:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2958a134514so33253725ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 05 Dec 2025 08:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764952204; x=1765557004; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uY/zz/FmTheKinzMsruxPAeAFgeFSh6MXrbrP2Vw8Ck=;
        b=Jqegb3XfcIXVgaL93SzccPHy3/rUGqPpnVxMS1AfkAl3nKUPRrb6+9KGQMb7opodXY
         1eZ2n9r1/mPXz5X/rb2hFh+CluQJdz/PWks9CDbzMleogoRx7kaLyXJsgo6/r8bRGWKJ
         KY6O9AsMpgKU8rbYm0UVwttbJe1KhjoibCV2HlTfoGnsWh1AcymO382MvT4mH0+9PL3u
         RG0bkLZ4toYFf6RHc+ZMFGMKa2axi4ravKc80yJMiD+ML4m8dEwQte+sR3tez7JI9qEV
         Dk2Gdn30syX7BDpM8uQKhkfpF9MqbRtJAT3x6ue/1sodj32zqjjL6DWAQjJZ1Q0uG9xR
         EZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764952204; x=1765557004;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uY/zz/FmTheKinzMsruxPAeAFgeFSh6MXrbrP2Vw8Ck=;
        b=w6wCBO3HkuH4RL6zRvqRZyhpDRt0kUId/X+OgvTi7lwwF8U6Y8ly2WKMwbvbbV4C5m
         Eo9Muna9riNm1lGqw9o/q96aRkoRnc3XyBT6EqlDAKvnj68pemf+3aR4E+lHcR6EXIVY
         ckxZ0azrinvsTXMS5bVQmfLCVtfKq6qJelqEAeBfPqTYhg19rL20amRjYxj3gs+mDKoT
         LO0GWzNYqS/CMRHEJBMNamK/7tnuooncIEa0LlW9Jc0ZI9h2MT5ipv/vI+OoKRtAgU/T
         McO0T0SKAsE2KVLTi6bNpF6brTo8BgcVblqLlaS3QwD/Hh455HaFOyOgfO5Oo4GxyhlV
         IIEw==
X-Gm-Message-State: AOJu0YxEjbwd5mAesK6Pn+xt9qwO9MukvvRBwACA2jHzUI1pezCC8qWR
	SaxCoIdA5o7vT0lxbTo01kotSzMUnjXnp1TYLIf4KShUwZabIngry05VQg59yBc+7Cw1gnjApk0
	DMtIgSZ8AwLQ6peBL+MWjFf1B4900nQYRqU5LAELIl5sJpI4gRxlmJr/e+mzr6eRW64Qvow==
X-Gm-Gg: ASbGnctBXndmwO2sEdLyMrqw39gqsJNiNtydn8zlUpk5nXZ7oqtDADE+SDj6Ai+wQGW
	nHXHd+a3h9f0Iy8QYt05FgDEW7B+D9KL02Rc1fNOQ8h42YH/R4UZhKRwyRbugbwRHWN6RwD3rKz
	SduKu0wbZ6Ms3HnpZrCKjnZZlYcwLtWlOLCiIj/oI2QxGPVRz6+0tc2/H6XaV1tKnLkxM6Jy5wx
	KQ9ko8wcI8XAScMnxgwUwfNJVkJBiP4IKCJnrsuG0ZuKi0HZ+XBNwQaxr6XjoVfUuLPsdzNX8xs
	Zmk5HHra3R79bmcVr7W4IIN3MFaGtHSfDYLOos0Ax9oDGzInvtRf5/txrOYtNixgdV24aqY8yQL
	P5uY7eVIqdsEqkckxWyXWWaHw5TWGSBP8gxWywJMRYUW9Mw==
X-Received: by 2002:a17:903:1b28:b0:294:ccc6:cd30 with SMTP id d9443c01a7336-29d9fb6eb47mr88186835ad.17.1764952204100;
        Fri, 05 Dec 2025 08:30:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoqCm17nT0SnoxUP5EoDhHux+tD0gpH6iUAYDqqKgBNd2YHlT+I8Pl/pJ4QXlhgtjs1gu46A==
X-Received: by 2002:a17:903:1b28:b0:294:ccc6:cd30 with SMTP id d9443c01a7336-29d9fb6eb47mr88186545ad.17.1764952203564;
        Fri, 05 Dec 2025 08:30:03 -0800 (PST)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae33c2e2sm53266725ad.0.2025.12.05.08.30.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 08:30:03 -0800 (PST)
Message-ID: <f4e1e95f-672d-418c-9f3a-e47d01a1fe91@oss.qualcomm.com>
Date: Fri, 5 Dec 2025 08:30:02 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        jjohnson@kernel.org
Subject: [PULL linux-firmware] ath10k, ath11k and ath12k firmware ath-20251205
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=DOSCIiNb c=1 sm=1 tr=0 ts=6933088d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=81yDGmwx11_j3xA_CzoA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: WjzjOwPbasQNuACN5h9Qeq0T331bShZG
X-Proofpoint-GUID: WjzjOwPbasQNuACN5h9Qeq0T331bShZG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDEyMCBTYWx0ZWRfXwfzH52zYvbNd
 OSLQNvtd3rNjxE1nXwk9+cyWVapG2DztNszOuBnGgA6i7htEz8z6C3MurSviA2zZsbDe/poTdDl
 7hPzlXQtHTNZOQJkkEECkQRbgwiIxfPUAdzPi2RmO+NqJqQlsbnI+aTf5cFrNfoIFoDbm7qbUju
 d7N903rshtGmz16NUl0xwLG9QgB1HwJILJvK7Dkyg7f1KHDmSBIiNXmhONSTgkh9trZQrl0lbE+
 RaowSZruZaU4B+3XYDy+O044V0m1rAhH7xh4DHrgQJZa+04nADx0XD+Bgpk/vLh9cLBsUJRRRSZ
 paRWKpu9fvkbz0D05D4952lYkqP8rLZ3nSR+8HssGcQUjuV524hEWI7dgkpRMqiBXORNuvfJy+u
 oo47AYZZbJNSEgQbQQEna8oBvKsqEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_06,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512050120

Hi,
Here's a new pull request for ath10k, ath11k and ath12k.

Only ath10k board files are included this cycle:
QCA4019 hw1.0: Add Netgear LBR20 specific BDFs
QCA4019 hw1.0: Add Meraki MR30H specific BDFs
QCA4019 hw1.0: Add Meraki "underdog" specific BDFs
QCA9888 hw2.0: Add Netgear LBR20 specific BDFs
WCN3990 hw1.0: Add board file for the Arduino Imola (UNO-Q)
WCN3990 hw1.0: Add Xiaomi Redmi K20 Pro/ Xiaomi Mi 9T Pro specific BDFs
WCN3990 hw1.0: Add board file for Huawei MateBook E 2019

Please let me know if there are any problems.

Thanks,
/jeff

The following changes since commit a0f0e52138e5f77fb0f358ff952447623ae0a7c4:

  Merge branch 'amd-staging' into 'main' (2025-12-03 21:05:40 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git ath-20251205

for you to fetch changes up to 05c97f71a5336854054db1dd4acdaf68c5b7c144:

  ath10k: WCN3990 hw1.0: update board-2.bin (2025-12-05 08:20:14 -0800)

----------------------------------------------------------------
Jeff Johnson (3):
      ath10k: QCA4019 hw1.0: update board-2.bin
      ath10k: QCA9888 hw2.0: update board-2.bin
      ath10k: WCN3990 hw1.0: update board-2.bin

 ath10k/QCA4019/hw1.0/board-2.bin | Bin 1822336 -> 1895232 bytes
 ath10k/QCA9888/hw2.0/board-2.bin | Bin 218596 -> 230744 bytes
 ath10k/WCN3990/hw1.0/board-2.bin | Bin 670116 -> 742192 bytes
 3 files changed, 0 insertions(+), 0 deletions(-)

