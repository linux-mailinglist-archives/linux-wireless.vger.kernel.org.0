Return-Path: <linux-wireless+bounces-33074-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLFdKGSBsmm6NAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33074-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 10:03:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2891026F559
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 10:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA7BF3023E27
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 09:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4015438B153;
	Thu, 12 Mar 2026 09:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="Hngzpvk8";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="yx2DjvBn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D3338A734;
	Thu, 12 Mar 2026 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773306205; cv=fail; b=UEKOZJsXk0KbEC1SGTZXfACnPxEhWJPyQPzLjRDB8eiVFqhNKtbddkOy3O5YBcy74zimqVEcSEA+jcdNuk4lpAH/c+dWx/w7YuObWGjW/JjxwK0x641wVuka++1NLgfZ5TJu1a43+L0YZ+LTOn/RDaZB+zu1i/pXD4hvpvAG0Yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773306205; c=relaxed/simple;
	bh=q1Tw3xlnVCZV1TDO3lR/147pV75HK1fnGtW9UZHbbTg=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=hi0cKREEJHxXehztPoXHpT69rRBOOgTYvTi0fpcjZvSt2y/tzXHX+4+GeKyYh+IOhLZgvQYmAcHiAPPE/NbZHlufYEIHBOIrpq7xbCL8sTwbiTLpybOR8bStNQbug9ERMGQms1akzn5madG72FPTsEB3TfADIP6Quq5BDwBAWa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=Hngzpvk8; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=yx2DjvBn; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C5iUef3894633;
	Thu, 12 Mar 2026 10:02:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=IimIQMbMSdapUEulkEDKvt
	TbIkvxYo9Efn9sovu+eTA=; b=Hngzpvk83X4xnD4UrZb8SkauqlWoeDSxlYBjey
	6NF+iOh+0f09eiEBUjEUrTPrULTETSfRG82+9p+Qf0aQU3panroMHDXLjpdTmp4R
	hmXrAmgTXaQtH98O4vox7hGQuOw3C2Z6Q3EWsm/20LXQvtPWSw1V1RkgJnjgufWk
	Sq4l5UK9ej4RoH7El4tYX8j7hwPPRoiGtl/K/2dsllWSxCDh2ExJUjTSIQb7tTic
	FmBnvpnfxpumkqcTSAExoqbYqGCpEbJSmf751AiK5StpGYz8fhWcDTVwOGyQoU7n
	WHhdxmi4je0XLS+lp34k0EnDiSbuFCaJIgXFyoJsvAWfnleQ==
Received: from db3pr0202cu003.outbound.protection.outlook.com (mail-northeuropeazon11020142.outbound.protection.outlook.com [52.101.84.142])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4ctxy4heg8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 10:02:56 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDk82S4ibEvJGgV1Vix2VKszzhFjoW0L3o68lfcxbakszVr1A58kptq0vybJpis9FKxIw7GtOvaTFmbbQpmQRk2NPIVZsjDA9rBRSYW7rjNAVqiot4wtLcr5Rx+PHxGyqQidSIv2e8kyHiqq7nJI8S6lLtxNThZKKHzboaV4ccmOuWzks828QfSGOd40t9GpI8WrhI1vC0aqfx41BR3m//L9MNeLuhsQY0uChA+6oDTS6fdXLllPxr0tkyTGwGomfuzdyUPjARvA8sP7fJohv/0Na9QQXqZ49Dm62CyUzyVwVEY9VC0nk7Eea6ayGScJhLED7U6GZg+0cgX4bqjGtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IimIQMbMSdapUEulkEDKvtTbIkvxYo9Efn9sovu+eTA=;
 b=cr1JrfTKDOR2CJ/Y3RcoViqCwfOLJZ2UcjXVPHcbv4oA4aAHHnTUWNQD7H4X5esFv+qtscFE7N8e932hEHMOCqBJHSSCDiBqQVZ2vk2eafoGot3QJWdLU2xWaD1nZ6OL954v8HMRkaA8mQ8macCyE+nPE97/aBsypD+mo5re8mSYNcyW7sBXdaAOq1pWJqmf+EGP+fNJPncnZHjowH3qa0LI0RtkBjxVZtR8h9qwMlrjrZFpylljBWKDW/I+ULIBml5UnNvWsDGWOKEf0b307lVDgxdLsWvmBSPmXgQ1rWFD97dLlZWw6N6TS0YYH3PV78UAfDHBQCbHJr2I9adKBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IimIQMbMSdapUEulkEDKvtTbIkvxYo9Efn9sovu+eTA=;
 b=yx2DjvBnliCLdLCcEhvMsbvAyMtYj4M4k6ruQFx495AC0EShHdkyKiMgUtbpbLr6hBku2Ep6Q+d6mnLGAwD6Ubzh9PbUB6pPQ+SpezI/Kx2pgwVUZTC2BOAiJuAiG3NUWOE4g5YDG6aZ6NkoU7jiUPnH6MaFOXVVAx61LMm9D+c=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by DU2PPF3CD3900DC.EURP192.PROD.OUTLOOK.COM (2603:10a6:18:3::98b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 09:02:53 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8c02:9739:5f2d:b147]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8c02:9739:5f2d:b147%6]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 09:02:53 +0000
Date: Thu, 12 Mar 2026 10:02:50 +0100
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: ath12k: handling of HE and EHT capabilities
Message-ID: <abKBOp8Jc7f7U0T8@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GVZP280CA0093.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::7) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|DU2PPF3CD3900DC:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab5efe3-ef1f-4e53-8ef1-08de80162509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18092099006|18002099003|56012099003|18082099003;
X-Microsoft-Antispam-Message-Info:
	680iMFN9ji8cmGTlL+z440n5dI+NIT6RpMBBCcM6W979drNIz/EcOhUU1Wt33eh/z/AKqLyCVHaNp7q6HvSyRUzkQRmi9krkr17F978g0hBtYDEUwFYWFefvBqc6BGJbeksKGLSfn10g7gtIOYkpBsOJdc+TqE2Os5cDHeHURyBdPuSt0Xf5tLfh0UzgSHJ6cJ4DiRvQiW+gwKZEb29yh8QB8VLN+NYWv7IFLG8RKo86eUaPUivc0mGGk+PoRRBFJpaP3UBnDgpTuMFIGUONLlyQVKlalndxCM+ODpXNrtdoSFqn1qEtgkHEFjOi5WoIo4VfqML2UbmqDntldZ9kyS+54TxZDqpyEFc0jH/mjpsnX86s6GmOtp7NToGA1EDZckq097vMvBgwJRgf1x0v5q0DA13LRLYqqbRC/MaM1abRTQyOzpE5A1vZFJFtNLUB/LMd0dRvK0B+5coaI+AfVqgLQzYVkYzKDyh6/LLGu258SIAJAm5Ho14fblKxZSPesP67371lXhHh83RS0f4NQNgXQ/BVQLgkIk9y3p1TZCDb+yxqLFWbwk/XFMk5jE6ZR/5pu0Wxg+3rU3XwdF73tF9kRA+GdcjDmmyyRypyurkU5tW/t/g4tSQOwtB7snHzqRgKpdPjcsTChvo0D6FpV6XsaOUqD9bAv/nGyfExM79BUx/Jfmw/hlc+CiLqn9gtdFdZln1veGaQuGmRo9PVoVR34QLLC/mXR5gyaV+bP6U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18092099006)(18002099003)(56012099003)(18082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGlQV0FBUzJQcGdvVTZwWjVNZ1lobFFCNlZQUXE0U3dnTEMybGtxaWtaTWxN?=
 =?utf-8?B?U0RMSk1zK2NXLy9xZ0pTZnJ5alE4NlkxTU14YTZzSTgxYUdWcTMwNlZLMkt2?=
 =?utf-8?B?dUNGTExvdXFCR21Wdi8xVmpFektQRklPSThtZ0pzcUMzeXRITVVTVVNGamZ4?=
 =?utf-8?B?M1FaQ1RGZHRVYW9nWTNVT0phdE9HYlRWbU9OWThHYVRBQlBkSVBmZkNlamJG?=
 =?utf-8?B?YU82bDg3QjBVTkpYcGcyMi9iN1BsK1owK1hkRDhyYTQvcUJPU0N3MmRPWEc0?=
 =?utf-8?B?REdGbG94SjJyREdGbFhyMzcyYklsMXZTQ0pPNG1WUHVJWGREeWJUUnVYWWdP?=
 =?utf-8?B?S2RJZlZEb2JaUEJHdkhjS2h5K2oyenV5TjcyMzlsdHZFL296UXBab2Y1N1ox?=
 =?utf-8?B?b2Y5V2pxMXRqNFlmd0tjQW9HR2krZ0FWTk1nSzJEWHRFRDdtZDRYMk5ZaDk1?=
 =?utf-8?B?M3NMM2Q4cDhxRXRkMDBmbFdITWliQkdHR2Rqc1VZVTBYNGhtdUxUR2NPYnFX?=
 =?utf-8?B?d3VvL3ZsYzlFRitUYkRRRy9qSGg5UUl4dzJNSFpVa1RMZlZNdzJDd1RJcUVm?=
 =?utf-8?B?dkZqclc2czRVek52eVNEOHhlaXd6alp3OTMvODBsdldkK0EwdUNpQ09IMW5q?=
 =?utf-8?B?WjM4SlZZWWVwdlNzNjRmV1V1cThnZ1k4ZUI4ckcvZ0lpZ3pFYkswMnRQTC9L?=
 =?utf-8?B?N1pVYWhtWkYrSWtFdmQ1SHMxY0orV0dRMWNWRzRCcmtkMnMyNVdoYU80eC9S?=
 =?utf-8?B?NGRQcStXb2hWZDJYTU1zdVlnaTJaSTlXU1lDeFAvQ1drQlpoSEp2b0NvQUNs?=
 =?utf-8?B?d3IwMFZhd0JNdExqcEVTZEtjREk4M1ZXUkZTRGJmbXl4dndlZmg0SzlxTDFw?=
 =?utf-8?B?R1VZK25BNldyVzF1ZmtLb0dYUzhDYktLeCtpVXdiZDdIM3d1YWtlY21FenBs?=
 =?utf-8?B?dTcxaW9UMC9oNVNiSlFlbU5odmJMWE9jWFVsa3BKbFFWVHpYb3UzUExmMklu?=
 =?utf-8?B?bk1uTWxoMVkrcm9lZlhRR1JiVmdKcVMydFUwUnNKSXBYVnM0d1ZxWVZEcllT?=
 =?utf-8?B?ejZjWUdnbXZsSE1VcS9xRmV6VWJIQ283bThnQ3EwbXR0NHRSVUR6eGRIY3Ry?=
 =?utf-8?B?cG9YSkZZMmxTU2loQ0diMGpTV3k1ZmRmbVRLMmpRRUI2Q2FOV1BwM1FTMkNR?=
 =?utf-8?B?OW9XUjhBNjFSdUZGMWNValVIZ09GdjVQa1JIcEs4RHpaSVlFdFlnaVV5eVFl?=
 =?utf-8?B?UW5qMUdoVFhwbVB6WE5UVW1aNjFZNWdKYldZclpJcVh4YzJETmVSaVpCQXo4?=
 =?utf-8?B?b3l1aFRpWDh0STVvekNLb1hwMDFvMUtZZWx5NFpreXEzV2xraFpQZ2RFaGdX?=
 =?utf-8?B?UXZtZlJxaVdRS1M3M1ZVbk9hVzFEOEcrOFRpTjdpVUQrQ1JTM3A0WWljSms1?=
 =?utf-8?B?QU5wVERlb3MxMDdvS3JXTUlIU1Q5V1hzdU1WYW1KZU9XQllERDhrcHFxWTFR?=
 =?utf-8?B?VG5GbjVCaFdVTWs3UUNDWHQ5dHB1RG9DV0xKRmpmVVZMRDl5alhXSjd0UVZl?=
 =?utf-8?B?SmlXN3ZtR054aG1aR2RNUEtuMU9EVUpMV1ZRY1IwclVCcnJjdGtjM2JnQnZQ?=
 =?utf-8?B?L1JZa1FNeWNQRm42NUtVNnFTTXJqL1pTSWNhMjVYSTdxSVJMYzJCS3VHWXJX?=
 =?utf-8?B?M0V4SHhoZFdFZUs1MlpKdmdNM29sWDJiZ1ltWXR5VEhmUUVBc20vNk1HNVBX?=
 =?utf-8?B?YzkyM1IwMnBNa2hma0FqNEtwdlg1N0h6R0JoM21SMFF3U2pFTnBiN2VCMzBK?=
 =?utf-8?B?bzM0OTBJQWlDeVZVSU1CZCtUZzFVeGsvTWJHZW1BN0tuRXNrNmJyVkJZamYx?=
 =?utf-8?B?Um16dE81ZjdWYkVRZ05jMzRWWU9wRFhmTXdCalFZTDdCMWUvRzNVY2h6aHE4?=
 =?utf-8?B?cENjbmdMRHpMUklIM3JmOTY0anVpdW94K28rcndDNjZrakpsMUU2MXdvQ2hL?=
 =?utf-8?B?THlhcDdNanRvMzVscTRKMnBLL0ZTczU5MnJsRkxBbjJQR0xRYjRobmxBak05?=
 =?utf-8?B?dTdrUjZ2TGxFRyt0aExSRTFMV010cDhkL3dCcWd5SFJwWXdOK1R6Vll2d3VG?=
 =?utf-8?B?cElrdlJGVUQySE01eHpXcmhUZW5CWEFXOEhKYzRjbGh2S2xSUHZ6TzBrOEZv?=
 =?utf-8?B?TFlkRVNVSWRicU9ubDJBakR4ak0wNUpVTnEyUjdhd0dQQVJNZmd2S2trQ3B6?=
 =?utf-8?B?ZlRHL3BLVzJwMjRQK2c3S3VNbER5ZEV2elNtYTVXb3VqeXNSelhpRlNLVG5a?=
 =?utf-8?B?UUJHM1dGMkxETWxwYTlLeWxJODlTbjJLR2xKazFDYUwzUHR1bEgxdz09?=
X-Exchange-RoutingPolicyChecked:
	XB5rCA8/ZN4fd4JijRfy0Oyq7rwIbv1EwBE1gBk+StjBIlYPnZapzbUZbhrLTxoA1usvlv9yBREo/3NC8FzAwEqG/DCl2AH/k0zx+PLq7DVkrGvDz6MOb6dkhgsIaRkL63jIdi0FajXDWiqzDP6o//EK0tNsXZ+MbElDDvxV4b/3l3NSTCPxJ+b8NW5V8zEl6sKjTtjrw4VR9BrQ4npfaap8XAmctEOfh2+Ly/QrI6PtYXYY3UHAuragYDbe5xjcV4xV/AcDix6DazSRohhtUrqyaN860aI3jTzh+uFH8R9+jcOkC+zcb8r8ZhZE9N8iXKVyUc6ZgP0p87AiT7pJbw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vQ6rOzAAu6gxIUDYkLw3T0NevHgztsYU83drRH0p0ltqBxFL4wIOg0qb/OThidg/WXaqt7S8swOAP0kNzBWII3ogBzLscIpHo5ra8WvBiTzfDcIlzw5qeOs3C52LbOMCkfg2q3Vmd0gXfkBtn6qVOf/H0tEDOmuGaDTptZ+zFkNC7/ozg4V8wjJPVu94YnHDcb6Jquf7o5xFehbP91jd5q+muibAvofV3JoTAZ1anl8rREk7zviKhyZPjUWyaR1E0/cGoN2maiEWKOEbToCTLEZiEUniHnhUeSraz9s7UABCVStDatFQf214jRuhwlxF5aCHFjwxBMFPpx/0zjV8p/NZGEPb3ynLQrqfbIIuYXANcESuOgU5sWSCQYaKeQ3t8CKLYtXwtFnjY2D2IAILRMGmIcW5L1W0F+TDW4e1q9fq9Gmm+1MGv1dNdPbK3sSccqXxtKFWnmio3jHB4e5rF3Qtn41pNS1Bme1PH5Kq99awyzBORkEnCv/qGLlOKt9V1WSjQTqnc1gjQzDmDx3DbBpiWuQv4HPnTIn+KxsDRYVz4FHgRuhwbKec0qCY8ZoDDY1IX12cYjh+ElcK2Cauzj4TK6cUJw5nQiZ8eDrQDtYo4Pn0LtHfbUOohvm8hcp/
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab5efe3-ef1f-4e53-8ef1-08de80162509
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:02:53.2984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TCEYB9msJyfYIm++ShKMWUsXKmEWu/0L6H1QPi8Nr+pe/zQ7DGAGY/0LZfR0VDXDX3C23R4RfXFJ09qabtmG4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PPF3CD3900DC
X-MS-Exchange-CrossPremises-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 104.151.95.196
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: DU2PPF3CD3900DC.EURP192.PROD.OUTLOOK.COM
X-Authority-Analysis: v=2.4 cv=deaNHHXe c=1 sm=1 tr=0 ts=69b28140 cx=c_pps
 a=vA9PrX/BfemLN70XEOC+sw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=8ys4xmT3Mru1TjC2zVq1:22
 a=I_8DsNCv6K1W6gimf3sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA3MiBTYWx0ZWRfX5TvmjBKNFQpc
 23M9prSqL/3SZ7whmi7ynOZTCWKUnFstPC2JUuq441CTsuP6v2rqGM+lST0pHp9p5wdgEZQuWrw
 I+0DtWSGnQhADpMSq4pMhQhQcvtBGuvB52xS1bZf2onmsycBnKHIx3yhUf1Ib80qSX4poUFoXOf
 fU0GB1Bzb6rWj8pT1xAdVoWvVCmZccq2Lrr3sNQzmQF6dDS+mMslan8eDGlC0qkWifGAaZGZlJH
 TytflpIz9rbeQfXA86Y7d2IIiq5e2QqDk7Nzk4gVaWmPteQmnF844DbQ3KF4kCfH9CLXXTpn15A
 P1V+Z8sVDnsz6EtFohZ4zwN94cL/GN4mFrr0aCraq+efGElBysO3y5y0c3ayyhjYVZRXiO4RmYs
 OXYAuH7rBRJkHEAcA+MSLr13N2vT1fu7zndJNKsxT4PTvnBkZ3BhjlawFN4VdZb+CeP+oG8IM+p
 fDze186NZFckYulMG9A==
X-Proofpoint-ORIG-GUID: lUN3OE2hTXLuqPO7GVi-VkrXdDQbpJ7F
X-Proofpoint-GUID: lUN3OE2hTXLuqPO7GVi-VkrXdDQbpJ7F
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33074-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RBL_SEM_IPV6_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:query timed out];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2891026F559
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello devs,

I’m currently trying to fix the HE and EHT capabilities handling on the
big‑endian platform. Unfortunately, I don’t fully understand how exactly
these capabilities are supposed to be defined.

For example, I use the `iw` tool to display the capabilities and their
descriptions. The code for that has the following function prototypes:

    * void print_ht_capability(__u16 cap);
    * void print_vht_info(__u32 capa, const __u8 *mcs);
    * static void __print_he_capa(const __u16 *mac_cap,
                                  const __u16 *phy_cap,
                                  const __u16 *mcs_set, size_t mcs_len,
                                  const __u8 *ppet, int ppet_len,
                                  bool indent);
    * static void __print_eht_capa(int band,
                                   const __u8 *mac_cap,
                                   const __u32 *phy_cap,
                                   const __u8 *mcs_set, size_t mcs_len,
                                   const __u8 *ppet, size_t ppet_len,
                                   const __u16 *he_phy_cap,
                                   bool indent);

For HE capabilites in 6 GHz band I couldn't find the respective function.
Then I looked into `include/net/cfg80211.h` and examined the structures
that define the capability data types.

    struct ieee80211_sta_ht_cap {
        u16 cap; /* use IEEE80211_HT_CAP_ */
        bool ht_supported;
        u8 ampdu_factor;
        u8 ampdu_density;
        struct ieee80211_mcs_info mcs;
    };

    struct ieee80211_sta_vht_cap {
        bool vht_supported;
        u32 cap; /* use IEEE80211_VHT_CAP_ */
        struct ieee80211_vht_mcs_info vht_mcs;
    };

The structs for HT and VHT use `u16` and `u32` data types for the `cap`
variable, matching what `iw` does. That part is consistent.

    struct ieee80211_he_cap_elem {
        u8 mac_cap_info[6];
        u8 phy_cap_info[11];
    } __packed;

    struct ieee80211_he_6ghz_capa {
        /* uses IEEE80211_HE_6GHZ_CAP_* below */
        __le16 capa; }
    __packed;

However, for HE the types differ from the `iw` implementation. Here, `u8`
arrays are used instead of `u16` for MAC and PHY capabilities. The 6 GHz
capabilities use `u16`, which is also different.

    struct ieee80211_eht_cap_elem_fixed {
        u8 mac_cap_info[2];
        u8 phy_cap_info[9];
    } __packed;

For EHT, `u8` arrays are also used for both MAC and PHY caps, instead of
`u32` for the PHY caps as in the `iw` implementation.

The current `ath12k` implementation always uses `u32` values, which does
not work on big‑endian platforms:

    ath12k_pci 0001:01:00.0: BAR 0: assigned [mem 0xc00000000-0xc001fffff 64bit]
    ath12k_pci 0001:01:00.0: MSI vectors: 1
    ath12k_pci 0001:01:00.0: Hardware name: qcn9274 hw2.0
    ath12k_pci 0001:01:00.0: qmi dma allocation failed (29360128 B type 1), will try later with small size
    ath12k_pci 0001:01:00.0: memory type 10 not supported
    ath12k_pci 0001:01:00.0: chip_id 0x0 chip_family 0xb board_id 0x1005 soc_id 0x401a2200
    ath12k_pci 0001:01:00.0: fw_version 0x111300d6 fw_build_timestamp 2024-08-06 08:43 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
    ath12k_pci 0001:01:00.0: leaving PCI ASPM disabled to avoid MHI M2 problems
    ath12k_pci 0001:01:00.0: Invalid module id 2
    ath12k_pci 0001:01:00.0: failed to parse tlv -22
    ath12k_pci 0001:01:00.0: ieee80211 registration failed: -22
    ath12k_pci 0001:01:00.0: failed register the radio with mac80211: -22
    ath12k_pci 0001:01:00.0: failed to create pdev core: -22
    ath12k_pci 0001:01:00.0: qmi failed set mode request, mode: 4, err = -110
    ath12k_pci 0001:01:00.0: qmi failed to send wlan mode off

I want to address and fix this issue. However, I cannot apply the “never
break the userspace” rule here, as it seems, it is already broken. Can
someone help clarify which datatypes are supposed to be used? Once that is
clear, I can fix the `ath12k` implementation.


Best regards
Alexander Wilhelm

