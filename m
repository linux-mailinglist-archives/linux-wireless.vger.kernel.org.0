Return-Path: <linux-wireless+bounces-21056-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77692A7869C
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 04:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 225493AFDD0
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 02:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955A41B7F4;
	Wed,  2 Apr 2025 02:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="REkYUgL1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F822E630
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 02:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743562137; cv=none; b=lYRzqGZMetEFnlhtOI+JUGjo1b//gbo7ZSMOPfX2V7/H+HmF1Ns7s3TQpqLWR8kuxA3YMZ63WW54THB6yfh7ayYqhBO7Vthd5yvzWxspjRT2gkmxA0TD9VsE5k3mL2ILiF7G9/83QrcY5vawqcADlo8DMmdj5VQY5nhFARoMxS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743562137; c=relaxed/simple;
	bh=NQ7cpRjb+sZX+0g+F0WldQFnfYQYWL+9W5TJ0cIvIUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HN19d0F0jqex/BsUi5DFZnt55rRYIbU4uIguBY9CwN+Diy8PKfzD3Pw22Q1Kftn9jrNqtRBn+iLBK7XbgRXQuBiupzKI26ea4E0YqVJlmp8sCYi8iGwPWu+wruKiwvLVmaGVPXPkJqVQYiIfLeoCPhA7UM82DolHhgDk67vFuk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=REkYUgL1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531FdXtY008471;
	Wed, 2 Apr 2025 02:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GrMhgc1KovsN5I4sfTdMTKczDTQ5qElsQ/Wq271LWbY=; b=REkYUgL1lEQ8VKS7
	qYDaiERHBtFcq7zJAxYMqNbOjs07W27RW2ZSRyHZa+fnV9Aa3UANrwIq1YoD4Tt/
	ZHxeQsc2zLPyegZaBeb+1KyL4OwMruuGanlTqivQ2RXEEaKFF02/vNCaNUeaRhW3
	i9+4G6fAAMh8LopXWo3LTzqEGsITZMebsMphEcUX3xzLeRPEircKbyn0DLtZq6OW
	SkJClUuRgIWbdgzqXImHQG5QmQO8VYYaNmCri1iIdYuZFCkDlqyUikeMg+HLR9B6
	37IhNIzlDIVC0LO9X+xTHO2gZHZ0Sd/DGxZc2t8Iuj3cLYgpZBMVe1AcakNjCmWj
	8I1sYQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45r1xnmbnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 02:48:50 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5322mnTW017425
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 2 Apr 2025 02:48:49 GMT
Received: from [10.133.33.114] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 1 Apr 2025
 19:48:48 -0700
Message-ID: <dc0abf98-862b-47f5-ae71-749c68cffc73@quicinc.com>
Date: Wed, 2 Apr 2025 10:48:45 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath12k: No 6GHz Wireless found
To: Walt Holman <waltholman09@gmail.com>,
        Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>
CC: <linux-wireless@vger.kernel.org>,
        "ath12k@lists.infradead.org"
	<ath12k@lists.infradead.org>
References: <CAMb39_ngQs8=FUML5QXMh2RmEZBZ2NwUHefhGoTkGtHat+KWJA@mail.gmail.com>
 <f45323db-ce4d-4374-9c93-0be4d0645fcd@oss.qualcomm.com>
 <CAMb39_ki7F1XgezyVfb9Tkm9D-FZE0XK3RcSYtFmFf0jP8-M_Q@mail.gmail.com>
Content-Language: en-US
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <CAMb39_ki7F1XgezyVfb9Tkm9D-FZE0XK3RcSYtFmFf0jP8-M_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: u8c_0ZNd0jDT7EAGsGj3ZuvdekBP_RQB
X-Proofpoint-ORIG-GUID: u8c_0ZNd0jDT7EAGsGj3ZuvdekBP_RQB
X-Authority-Analysis: v=2.4 cv=Qv1e3Uyd c=1 sm=1 tr=0 ts=67eca592 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=bC-a23v3AAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=djrh-veR_mV6KkF8jiQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=-FEs8UIgK8oA:10 a=FO4_E8m0qiDe52t0p3_H:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_01,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020017



On 4/2/2025 5:21 AM, Walt Holman wrote:
> On Tue, Apr 1, 2025 at 1:53 PM Jeff Johnson
> <jeff.johnson@oss.qualcomm.com> wrote:
>>
>> On 3/30/2025 7:28 AM, Walt Holman wrote:
>>> Hello,
>>>
>>> I have a wcn7850 hw2.0 based m.2 wireless card in my laptop and am
>>> unable to see or connect to 6Ghz networks. I have an ASUS BE30000 wifi
>>> router setup with a separate 6ghz only network, which my phone and
>>> other laptops can connect to. I'm unable to even see this network on
>>> this particular laptop. Months ago (maybe September), I could see it
>>> occasionally, but now it never shows up. I'm using firmware from
>>> git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
>>> and track the kernels pretty closely. I'm currently running 6.14.0
>>> built from source. Any suggestions? Some HW info is below:
>>>
>>> 63:00.0 Network controller: Qualcomm Technologies, Inc WCN785x Wi-Fi
>>> 7(802.11be) 320MHz 2x2 [FastConnect 7800
>>> ] (rev 01)
>>>         Subsystem: Quectel Wireless Solutions Co., Ltd. Device 8000
>>>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>>> ParErr- Stepping- SERR- FastB2B- DisINTx+
>>>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort+
>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>         Latency: 0, Cache Line Size: 64 bytes
>>>         Interrupt: pin ? routed to IRQ 111
>>>         IOMMU group: 19
>>>         Region 0: Memory at dd800000 (64-bit, non-prefetchable) [size=2M]
>>>         Capabilities: [40] Power Management version 3
>>>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
>>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>>>         Capabilities: [50] MSI: Enable+ Count=16/32 Maskable+ 64bit-
>>>                 Address: fee00000  Data: 0000
>>>                 Masking: ffff8000  Pending: 00000000
>>>         Capabilities: [70] Express (v2) Endpoint, IntMsgNum 0
>>>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
>>> unlimited, L1 unlimited
>>>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>>> SlotPowerLimit 75W TEE-IO-
>>>                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>>>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>>>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>>>                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
>>> AuxPwr+ TransPend-
>>>                 LnkCap: Port #0, Speed 8GT/s, Width x2, ASPM L0s L1,
>>> Exit Latency L0s <1us, L1 <64us
>>>                         ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
>>>                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
>>>                         ExtSynch+ ClockPM- AutWidDis- BWInt- AutBWInt-
>>>                 LnkSta: Speed 8GT/s, Width x1 (downgraded)
>>>                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>>>                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
>>> NROPrPrP- LTR+
>>>                          10BitTagComp- 10BitTagReq- OBFF Not Supported,
>>> ExtFmt- EETLPPrefix-
>>>                          EmergencyPowerReduction Not Supported,
>>> EmergencyPowerReductionInit-
>>>                          FRS- TPHComp+ ExtTPHComp-
>>>                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>>>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
>>>                          AtomicOpsCtl: ReqEn-
>>>                          IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
>>>                          10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
>>>                 LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink-
>>> Retimer- 2Retimers- DRS-
>>>                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
>>>                          Transmit Margin: Normal Operating Range,
>>> EnterModifiedCompliance- ComplianceSOS-
>>>                          Compliance Preset/De-emphasis: -6dB
>>> de-emphasis, 0dB preshoot
>>>                 LnkSta2: Current De-emphasis Level: -3.5dB,
>>> EqualizationComplete+ EqualizationPhase1+
>>>                          EqualizationPhase2+ EqualizationPhase3+
>>> LinkEqualizationRequest-
>>>                          Retimer- 2Retimers- CrosslinkRes: unsupported
>>>         Capabilities: [100 v2] Advanced Error Reporting
>>>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
>>> UnxCmplt- RxOF- MalfTLP-
>>>                         ECRC- UnsupReq- ACSViol- UncorrIntErr-
>>> BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
>>>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
>>> MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
>>>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
>>> UnxCmplt- RxOF- MalfTLP-
>>>                         ECRC- UnsupReq- ACSViol- UncorrIntErr+
>>> BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
>>>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
>>> MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
>>>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
>>> UnxCmplt- RxOF+ MalfTLP+
>>>                         ECRC- UnsupReq- ACSViol- UncorrIntErr+
>>> BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
>>>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
>>> MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
>>>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
>>> AdvNonFatalErr- CorrIntErr- HeaderOF-
>>>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
>>> AdvNonFatalErr+ CorrIntErr+ HeaderOF+
>>>                 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
>>> ECRCChkCap+ ECRCChkEn-
>>>                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>>>                 HeaderLog: 00000000 00000000 00000000 00000000
>>>         Capabilities: [148 v1] Secondary PCI Express
>>>                 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
>>>                 LaneErrStat: 0
>>>         Capabilities: [158 v1] Transaction Processing Hints
>>>                 No steering table available
>>>         Capabilities: [1e4 v1] Latency Tolerance Reporting
>>>                 Max snoop latency: 1048576ns
>>>                 Max no snoop latency: 1048576ns
>>>         Capabilities: [1ec v1] L1 PM Substates
>>>                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
>>> ASPM_L1.1+ L1_PM_Substates+
>>>                           PortCommonModeRestoreTime=70us PortTPowerOnTime=0us
>>>                 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>>>                            T_CommonMode=0us LTR1.2_Threshold=166912ns
>>>                 L1SubCtl2: T_PwrOn=90us
>>>         Kernel driver in use: ath12k_pci
>>>         Kernel modules: ath12k
>>>
>>> root@walt-ROG-zephyrus:~# iw reg get
>>> global
>>> country US: DFS-FCC
>>>          (902 - 904 @ 2), (N/A, 30), (N/A)
>>>          (904 - 920 @ 16), (N/A, 30), (N/A)
>>>          (920 - 928 @ 8), (N/A, 30), (N/A)
>>>          (2400 - 2472 @ 40), (N/A, 30), (N/A)
>>>          (5150 - 5250 @ 80), (N/A, 23), (N/A), AUTO-BW
>>>          (5250 - 5350 @ 80), (N/A, 24), (0 ms), DFS, AUTO-BW
>>>          (5470 - 5730 @ 160), (N/A, 24), (0 ms), DFS
>>>          (5730 - 5850 @ 80), (N/A, 30), (N/A), AUTO-BW
>>>          (5850 - 5895 @ 40), (N/A, 27), (N/A), NO-OUTDOOR, AUTO-BW, PASSIVE-SCAN
>>>          (5925 - 7125 @ 320), (N/A, 12), (N/A), NO-OUTDOOR, PASSIVE-SCAN
>>>          (57240 - 71000 @ 2160), (N/A, 40), (N/A)
>>>
>>> phy#0 (self-managed)
>>> country na: DFS-UNSET
>>>          (2402 - 2472 @ 40), (N/A, 20), (N/A)
>>>          (2457 - 2482 @ 20), (N/A, 20), (N/A), PASSIVE-SCAN
>>>          (5170 - 5330 @ 160), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
>>>          (5490 - 5730 @ 160), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
>>>          (5735 - 5895 @ 160), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
>>>          (5945 - 7125 @ 320), (N/A, 30), (N/A), AUTO-BW, PASSIVE-SCAN
>>>
>>
>> I added the ath12k list to make sure this has the proper attention.
>> Since you are building from source, can you please test with the following patch:
>> https://msgid.link/20250401020840.357-1-quic_kangyang@quicinc.com
>>
>> This is in my pending queue.
>>
>> /jeff
>>
> 
> Hi Jeff,
> 
> No dice on the 6Ghz networks. It fixed up the registration info, but I
> still don't see any 6Ghz networks. Even from an 'iw wlp99s0 scan'
> 
> global
> country US: DFS-FCC
>         (902 - 904 @ 2), (N/A, 30), (N/A)
>         (904 - 920 @ 16), (N/A, 30), (N/A)
>         (920 - 928 @ 8), (N/A, 30), (N/A)
>         (2400 - 2472 @ 40), (N/A, 30), (N/A)
>         (5150 - 5250 @ 80), (N/A, 23), (N/A), AUTO-BW
>         (5250 - 5350 @ 80), (N/A, 24), (0 ms), DFS, AUTO-BW
>         (5470 - 5730 @ 160), (N/A, 24), (0 ms), DFS
>         (5730 - 5850 @ 80), (N/A, 30), (N/A), AUTO-BW
>         (5850 - 5895 @ 40), (N/A, 27), (N/A), NO-OUTDOOR, AUTO-BW, PASSIVE-SCAN
>         (5925 - 7125 @ 320), (N/A, 12), (N/A), NO-OUTDOOR, PASSIVE-SCAN
>         (57240 - 71000 @ 2160), (N/A, 40), (N/A)
> 
> phy#0 (self-managed)
> country US: DFS-FCC
>         (2402 - 2472 @ 40), (6, 30), (N/A)
>         (5170 - 5250 @ 80), (6, 24), (N/A), AUTO-BW
>         (5250 - 5330 @ 80), (6, 24), (0 ms), DFS, AUTO-BW
>         (5490 - 5730 @ 160), (6, 24), (0 ms), DFS, AUTO-BW
>         (5735 - 5855 @ 80), (6, 30), (N/A), AUTO-BW
>         (5855 - 5925 @ 40), (6, 30), (N/A), NO-OUTDOOR, AUTO-BW
>         (5925 - 7125 @ 320), (N/A, 30), (N/A), NO-OUTDOOR, AUTO-BW
> 
> 

Test on 6.14.0-rc5-wt-ath+, with the firmware you used.
I can get 6 GHz AP and connect to it.

ath12k_pci 0000:03:00.0: fw_version 0x100301e1 fw_build_timestamp 
2023-12-06 04:05 fw_build_id
QC_IMAGE_VERSION_STRING=WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

yk@yk-Mayan:~$ sudo iw wls1 scan | tee iw_scan.log:
BSS 62:03:7f:12:64:64(on wls1) -- associated
         TSF: 606308271476 usec (7d, 00:25:08)
         freq: 6275
         beacon interval: 100 TUs
         capability: ESS Privacy SpectrumMgmt ShortSlotTime (0x0511)
         signal: -17.00 dBm
         last seen: 52 ms ago
         Information elements from Probe Response frame:
         SSID: MLO-KANG-6G
and other 6 GHz APs:
	SSID: 6G-gxia
	SSID: NETGEAR97-6G
	……


kernel log:
[88158.033218] wls1: Inserted STA 62:03:7f:12:64:64
[88158.033232] wls1: authenticate with 62:03:7f:12:64:64 (local 
address=00:03:7f:37:12:54)
[88158.033242] wls1: send auth to 62:03:7f:12:64:64 (try 1/3)
[88158.041895] wls1: authenticated
[88158.041914] wls1: moving STA 62:03:7f:12:64:64 to state 2
[88158.044291] wls1: determined local STA to be EHT, BW limited to 320 MHz
[88158.045719] wls1: associate with 62:03:7f:12:64:64 (try 1/3)
[88158.067045] wls1: RX AssocResp from 62:03:7f:12:64:64 (capab=0x511 
status=0 aid=4)
[88158.089090] wls1: associated

I can even connect to it by Ubuntu GUI.

Can you update to 6.14.0-rc5-wt-ath+ and have a retry? Also please make 
sure that your wpa_supplicant/iw support 6 GHz(or directly update to the 
latest version).

If you still cannot find 6 GHz AP, you can set debug_mask to 0xffffffff 
to get ath12k logs. Then give it to us.


> -Walt
> 


