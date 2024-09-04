Return-Path: <linux-wireless+bounces-12474-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDFA96B939
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 12:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694222882CC
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 10:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11CF1CF7A3;
	Wed,  4 Sep 2024 10:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TJvJqbFg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0ED3612D;
	Wed,  4 Sep 2024 10:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447013; cv=none; b=OhL8L5Ksiw10TKMzgsyQXHzHtPFDxsZtUB7WbOrg/pYTA9tCMhiFIY6YqQJfAkqlxp99NbLHiOCYRpVo6LY+k+VlNUvSHLHhJiqEA7CyTMCUGGU8JGhHOyoYXdQAP73U6D2Z1hs3ZKLJYvyeEKPz9KG5NJhWd5bFjZ8RasErIOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447013; c=relaxed/simple;
	bh=qCCt6akt6J3+5DzMZX5XwCF3hJaj/F746bDw4hPKOOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WVDIW8y6RAdTW6wYr39qfeDGlH32z0Ih04suR6CqLKKX3oPFsyYQE1Wq90aVjQ5EDuDugNYeXWKonDC25TYYhrngiywDmIFrPMxMWnq8I0tD7Xm90z+/B/3pGTgHlwDPdCYjRThc+wNfShztLSJpkqJByg4hOS13zd4EMqx06o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TJvJqbFg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48484dRl010553;
	Wed, 4 Sep 2024 10:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CukpPXmCtRJOKkmqSDQK/eI6qJTAIFrCRv7rp2CScIk=; b=TJvJqbFgsyMIHqc7
	nRrx4GbwLM8xOCxlfAb4CJoShVKhusGnYNnvFb94dd5Kwcy0rB1cxPkiP7Z+oMoc
	BENaQDbNbNNhoTLGQ0Vv1G3JYLER+huW0Cjxk5quM1pU0xh2sKe/bd2u3fINcant
	IVj8XzbNIDeqF/6ArNDTded4IWkga7mUCWnhVSf7SVd7L8RdgL5xVWPIP2rwEOYm
	p89mJqFwTFC70RFlUL31/yqAdrmnuYswdKptdiNT8qn5ex+O/0XevWN3ZTh22F9A
	jr7Q6LU27urexnm3j1NEC1yXTdS8XJJcYLsj4kQ46JrslemhujIPu7g7QM9d5PIQ
	Dcr7QQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41e0bhkntq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 10:49:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 484AnqNB028087
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 10:49:52 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 03:49:51 -0700
Message-ID: <50dd4471-d364-4ca7-b2ad-4274faf3e6e0@quicinc.com>
Date: Wed, 4 Sep 2024 18:49:49 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: failed to remove key (0, ce:ce:1e:27:bb:e0) from hardware (-110)
 (ETIMEDOUT)
To: Paul Menzel <pmenzel@molgen.mpg.de>, Kalle Valo <kvalo@kernel.org>
CC: James Prestwood <prestwoj@gmail.com>, <linux-wireless@vger.kernel.org>,
        <ath10k@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>
References: <d8253ab3-f4f0-40fd-a550-d75eef121b56@molgen.mpg.de>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <d8253ab3-f4f0-40fd-a550-d75eef121b56@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3rsVhnI6ql7LNGHe3zSdoNTv_eVYY3zk
X-Proofpoint-GUID: 3rsVhnI6ql7LNGHe3zSdoNTv_eVYY3zk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_09,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040081



On 9/4/2024 6:45 PM, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Linux 6.11-rc6+ logged the warning below when resuming from ACPI S3 (or unloading and loading the `ath10k_core`/`ath10k_pci` modules) having been connected to an AVM network:
> 
>     wlp58s0: failed to remove key (0, ce:ce:1e:27:bb:e0) from hardware (-110)
> 
> Error code 110 is the value for ETIMEDOUT. I saw James patch [1], and applied it, and the error is still there (as exepected).
> 
> Can the warning be improved so the user know, which component is at fault?
most likely it is firmware not responding to host remove key command.

> 
> 
> Kind regards,
> 
> Paul
> 
> 
> [1]: https://lore.kernel.org/all/20240814164507.996303-1-prestwoj@gmail.com/
> 
> ```
> Sep 04 07:21:38.469669 abreu kernel: Linux version 6.11.0-rc6-00027-ga91d08fcc356 (build@bohemianrhapsody.molgen.mpg.de) (gcc (Debian 14.2.0-4) 14.2.0, GNU ld (GNU Binutils for Debian) 2.43.1) #294 SMP PREEMPT_DYNAMIC Tue Sep  3 23:01:18 CEST 2024
> Sep 04 07:21:38.469718 abreu kernel: Command line: BOOT_IMAGE=/vmlinuz-6.11.0-rc6-00027-ga91d08fcc356 root=UUID=32e29882-d94d-4a92-9ee4-4d03002bfa29 ro quiet pci=noaer mem_sleep_default=deep log_buf_len=8M cryptomgr.notests
> […]
> Sep 04 12:34:55.826218 abreu sudo[25874]:  pmenzel : TTY=pts/7 ; PWD=/home/pmenzel ; USER=root ; COMMAND=/usr/sbin/modprobe ath10k_pci
> Sep 04 12:34:55.828046 abreu sudo[25874]: pam_unix(sudo:session): session opened for user root(uid=0) by pmenzel(uid=5272)
> Sep 04 12:34:55.869839 abreu kernel: ath10k_pci 0000:3a:00.0: pci irq msi oper_irq_mode 2 irq_mode 0 reset_mode 0
> Sep 04 12:34:56.005202 abreu sudo[25874]: pam_unix(sudo:session): session closed for user root
> Sep 04 12:34:56.161706 abreu kernel: ath10k_pci 0000:3a:00.0: qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1a56:1535
> Sep 04 12:34:56.162591 abreu kernel: ath10k_pci 0000:3a:00.0: kconfig debug 0 debugfs 0 tracing 0 dfs 0 testmode 0
> Sep 04 12:34:56.163115 abreu kernel: ath10k_pci 0000:3a:00.0: firmware ver WLAN.RM.4.4.1-00309- api 6 features wowlan,ignore-otp,mfp crc32 0793bcf2
> Sep 04 12:34:56.241683 abreu kernel: ath10k_pci 0000:3a:00.0: board_file api 2 bmi_id N/A crc32 d2863f91
> Sep 04 12:34:56.333784 abreu kernel: ath10k_pci 0000:3a:00.0: htt-ver 3.87 wmi-op 4 htt-op 3 cal otp max-sta 32 raw 0 hwcrypto 1
> Sep 04 12:34:56.417649 abreu kernel: ath: EEPROM regdomain: 0x6c
> Sep 04 12:34:56.417919 abreu kernel: ath: EEPROM indicates we should expect a direct regpair map
> Sep 04 12:34:56.418022 abreu kernel: ath: Country alpha2 being used: 00
> Sep 04 12:34:56.418114 abreu kernel: ath: Regpair used: 0x6c
> Sep 04 12:34:56.422440 abreu NetworkManager[610]: <info> [1725446096.4223] device (wlan0): driver supports Access Point (AP) mode
> […]
> Sep 04 12:35:12.042484 abreu wpa_supplicant[618]: wlp58s0: WPA: Group rekeying completed with ce:ce:1e:27:bb:e0 [GTK=CCMP]
> Sep 04 12:35:21.800998 abreu sudo[25953]:  pmenzel : TTY=pts/7 ; PWD=/home/pmenzel ; USER=root ; COMMAND=/usr/sbin/modprobe -r ath10k_pci
> Sep 04 12:35:21.803733 abreu sudo[25953]: pam_unix(sudo:session): session opened for user root(uid=0) by pmenzel(uid=5272)
> Sep 04 12:35:21.881668 abreu kernel: wlp58s0: deauthenticating from ce:ce:1e:27:bb:e0 by local choice (Reason: 3=DEAUTH_LEAVING)
> Sep 04 12:35:22.905717 abreu kernel: ath10k_pci 0000:3a:00.0: failed to install key for vdev 0 peer ce:ce:1e:27:bb:e0: -110
> Sep 04 12:35:22.906604 abreu kernel: wlp58s0: failed to remove key (0, ce:ce:1e:27:bb:e0) from hardware (-110)
> Sep 04 12:35:22.908927 abreu wpa_supplicant[618]: wlp58s0: CTRL-EVENT-DISCONNECTED bssid=ce:ce:1e:27:bb:e0 reason=3 locally_generated=1
> Sep 04 12:35:22.908995 abreu wpa_supplicant[618]: BSSID ce:ce:1e:27:bb:e0 ignore list count incremented to 2, ignoring for 10 seconds
> ```

