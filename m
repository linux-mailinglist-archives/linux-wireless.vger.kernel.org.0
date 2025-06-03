Return-Path: <linux-wireless+bounces-23581-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA39ACCF95
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 00:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA73E7A6AB2
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 22:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6901A2643;
	Tue,  3 Jun 2025 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iKpp/s7V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327944C98
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 22:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748988502; cv=none; b=TI/NWpVi61kPHr4OnHpqM4kfOMgoKjFfaUDCe6tdX8eecvqmWriMEMjBpd88G5nDf0Uv4d7VgFhfaKmO6muv/PcWowq+9YzWdWAl/tcLInnbLu0cC0epglHaBj2rLBVlf2AHpE5oo4Da7Biww6YDdV5ZdBGgXWWF4IXAoVf9bCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748988502; c=relaxed/simple;
	bh=1BSmjPQSzQncP8h3kvY04xuCznYy6YmQbL1QGxc/rPU=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=hO/Ge+m0CtZ/+PjmSYSVSFGuiLd3awZ5qqsNwNR7McJtATFOu3b2nGP4fMQFAYP+StyXE+AnHK6QlLC0T4PYcNpOD0PVuCRCXLuuGJymDPYp8oRUxo7uYPNcodLg6c9BPR2I3DxOxTonZXwlvWU9G342Ph2oNKUJAbdAAh76xmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iKpp/s7V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553JoNCM028340
	for <linux-wireless@vger.kernel.org>; Tue, 3 Jun 2025 22:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1BSmjPQSzQncP8h3kvY04x
	uCznYy6YmQbL1QGxc/rPU=; b=iKpp/s7VmSfz4ODu34j8YaaiFvk7yT41ghzhW1
	P+wSvAGYJFHH+x/nLHc8nio4feagp9Rl7dHkXatSZ8PAY9AE8RCYhZ7Y2SIDdZsX
	rb6F7NshB4o25SGdoKa2B3A7PNtZE5F3xO0QwP4rLOSqRNJir2hs3tTli1wwMiv7
	bKnrxXqujs8Ql4g18MD4f4Fk6UsIAsDLXGbFpPDdDIN+ha26tpdsZvNBNqaNr0P5
	vJoappII1nEcy3oxYHE6cltcLHe0Yc0pPaf0aeeFBQtfJWNcNar9x1quqFY2P0Lu
	ispzaq+53xm9DnpGmY6rh4qcMbWPubs+SRjxBvY8M+BcP8zg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8tv0nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 03 Jun 2025 22:08:16 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b1442e039eeso3715476a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 03 Jun 2025 15:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748988495; x=1749593295;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1BSmjPQSzQncP8h3kvY04xuCznYy6YmQbL1QGxc/rPU=;
        b=jQdNpldIra3kMPDVV81ll8HMn4E1L/8A+xwPV4TkRdJje6gJdReQjMM7PRLiyhWqD5
         aYNNJNsyjQ6d+15BerdDvXhX/lJEdyp0ryN2Q29nLGZ0J72/9S/GtDjaquytQVAsill+
         MsDwye8brWnw+jgW/Q3mWybywsw6WGbl/sOIlHbxOzpc3HiQoQLU9ESnxEQF2Hmyre4S
         R/hDHyCmuLMmT1dfJssdlOPK0+z0/w8WQs3Qh1eexy90VoY6MBpiJOvxYYn0+C4q09cW
         bNdqFrgFsGwmdAst5sd6vZQ4nVC3UJ7WBPqaEROtgbOlW/Et3th5/wIzBZXB0IDB4g1Y
         gqpQ==
X-Gm-Message-State: AOJu0YwCmSP3PXJl90waDxzQwWIfHXI4zyklOw2yJ4U05xJNvB0hPXiF
	SQ2uAYU0wUDAqM4nbLEX791qCJfn/4RLVg8qNfAdBFGBtJoFOfcGNJ8MVWlqGq4azBEQmZ96UEY
	mi2zC/D/9bdqYvtdqzt4cgXCSuLkyVjDGGIl5Bg+DsAPpshMbl5eIe+o0lAzWZ7eHVYKkhOSDLs
	M0Wg==
X-Gm-Gg: ASbGncs7Z6xhANZRQzn+sAeLh4LM6jXBksZ3efk40sMaKpmQ9dwI5wgz6Ep1TeBzDfe
	LYAhETzbrAisIts4KBk8Ds5a1RGyzRe7JQKxPYz4Oj8oKa/yQLjDiqE6j8JeUkKFEsa0Uv0wzUq
	miM8Achfg7s+u8Om83kZ2VgnrgupfHVrG29mMlytpcxIWMr3yq2gZ1inxc15K3KT34bC+GE7OUk
	JZoH4x9XdkTYIqmuro/G2EV8Mv+0X5nvevcDlPyjVW/AXRFkFubYCOa02SG5FoJJREJFZbay2kD
	JWkiqY+MVSo7Wop1ZgD4CF+qTWtMvJZueBvcb021ZdADczE1EdL6OCPV6Rs8ARb9swrtPUsjW3N
	fbwB/
X-Received: by 2002:a05:6a21:400d:b0:215:df62:7d51 with SMTP id adf61e73a8af0-21d22c0e00amr632903637.11.1748988495296;
        Tue, 03 Jun 2025 15:08:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE9zsh9gytRCddNybiurnoV2yVeW82NYEheJ6s0pgnAGULijmPXp1UjKJvWbVzorc9ccqzDQ==
X-Received: by 2002:a05:6a21:400d:b0:215:df62:7d51 with SMTP id adf61e73a8af0-21d22c0e00amr632876637.11.1748988494801;
        Tue, 03 Jun 2025 15:08:14 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2ecebb5cffsm7577076a12.75.2025.06.03.15.08.14
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 15:08:14 -0700 (PDT)
Message-ID: <6f4dc13a-b2f9-4f88-a1fb-8c457a6ed057@oss.qualcomm.com>
Date: Tue, 3 Jun 2025 15:08:13 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
Subject: Linux Wireless Request for Collaboration (AP-centric features)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7ktVYVLVWtMGhsBCYl5DDcMWINhfdJEa
X-Authority-Analysis: v=2.4 cv=Qspe3Uyd c=1 sm=1 tr=0 ts=683f7250 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=nFziqlwxMXhd2BqRVqQA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDE5MSBTYWx0ZWRfX8K2hOnpWYgfg
 5CKgvNN0bfBxDXhJdxJ4/98cziJ9QAOeuzgXShNBOG2VaOcf4YZn8stkJyVFKEHkbyt5N6V7QZ7
 b0c00FTnG2oGQ98soauh7xehWZuvxJVS9wJAM1lpp0Vig9aaFP7xjte1JTHQo682YKEUkbWlSYA
 /6URFCEuw81uyONpOe2ss4jZX8npo0++nZEgpXCDz7zd2q29J7t+i1PUxGmZVY8U2zoVRV3dw9e
 x/ioyZ30a8y7C1ryU2A/Noi3+5EGwUIxOy1C7VxTuFbrL1G7ZhTEAkbE7Mg3oOOdpiKcukiOMEv
 l8tglrY+UUXof+cnREFUw4n8ouYjrzSgVflwnLsZ0BEu/JGJ/F7EHpZBpScltF5owIe+Y15I4NX
 4pHXdsEsaPJpQF6zvWBmtt8DWUsWRvevHfMjb/gkYWxaL6xvOrhNvopnHJIBIYLDYeCKQW5+
X-Proofpoint-ORIG-GUID: 7ktVYVLVWtMGhsBCYl5DDcMWINhfdJEa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=3 mlxscore=0 spamscore=0 priorityscore=1501 mlxlogscore=631
 lowpriorityscore=3 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506030191

Dear Linux wireless contributors,

Qualcomm is seeking collaborators to bring AP-centric features to the upstream
Linux kernel. Some of the features we wish to see are already present in
downstream drivers, and we wish to migrate them to upstream in order to better
support our customers and the community. Other features are new in 802.11bn,
and we want to learn from the past experience with 802.11be (especially MLO),
and nail down designs early, before expending large amounts of development
time and resources on a design that is ultimately rejected by the community.

Johannes suggested that I poll the community for interest, and then those of
us interested in this activity can collaborate off list.

Specific areas of interest at this time include:
Robust AV Streaming (IEEE Std 802.11-2020 section 11.25)
Seamless Roaming (IEEE P802.11bn/D0.2, March 2025 section 37.9)

Please let me know if you want to be included in this collaboration.
Or let me know if you believe there is a better way to collaborate.

Thanks!
/jeff

