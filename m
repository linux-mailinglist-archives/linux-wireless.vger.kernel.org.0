Return-Path: <linux-wireless+bounces-38338-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DlF1IRx4Q2oTZAoAu9opvQ
	(envelope-from <linux-wireless+bounces-38338-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 10:02:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E61A06E1812
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 10:02:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=LgymLp+h;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38338-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38338-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1729C305B97D
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 07:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711633E5EEA;
	Tue, 30 Jun 2026 07:56:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012021.outbound.protection.outlook.com [52.103.10.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091D33E3DA4;
	Tue, 30 Jun 2026 07:56:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782806174; cv=fail; b=PQNx/22uz6yZPdQCRI9J47vHCzTF5/Nk//7VZ2UDN2xJ/zlRr+iVnhvujyrGypj2oMI7/ZV4NnguNMsWCE3m8gcC2Oj6NHookxSuz8Oeu2mRsEvRkFe4fj5mDOo7MARLlHc1VEoadDQTXUIFOhDbQfsggep9SCYsKdS2sYW80m8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782806174; c=relaxed/simple;
	bh=FrIOYRWoqIDjuNiMKH6CdXMiAA8eR3s/YtQIHLHG94E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SrLt+M/mb8DPce0mBePk2pAbAIgkSxYgjHz5fISBrK++7IvSZb+gghAckAAFC0Ej+7XbAEabCDagaAv95IRnqv7RwD2/62l8JvJxkXYtEbBBH9M3ygiJD77KmqJA5m+34O5rQmkxOjsEB58w5TeiTPHwkDjjIf6lekehpec/zyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LgymLp+h; arc=fail smtp.client-ip=52.103.10.21
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f20rxSDyYGrYDRFKokMvBl+YfNmUNNen2C6mFlLTgNIGoXfGua2NY1vxO2tZnhmmzAgxgP6EE4U6tJeTxnxDAhzg/trrxlfmBa1M5KfS+bbwC0dWsuLCthxXhY/r4n4fngjOzZHwMSDNoEuRi3GUT6Wf1x/zOuTLpyOfnj7UUcGk2I8qtQDtzVxHIS85v8fXXjCfbMqftoUDx63MnbGIWCTpzEb16SjK+VuZC5Kdfhui4kgynj1jG+xfkHe2ArseOLJ5qo22ei2aBDHmc+eOuZ4bMnGZocGNXMcCmn4I84YjSx+K22hciVcNgyp65J4NTPN/+UBJHkum2g0xU3hfkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcU75L4NhYOOqpBJVd+2XoryhV9nYIl5d1UbdDMYNbQ=;
 b=VfqFofwSO7RHXY9LdV2jOF/AT1UcIOpL26jvAa//666fVgMN5zL3ARE0litXVq5+0BS+Lyv+CjjiV3PvVIuSvoVxGIdC8odrOO8F8UIwjzebDTlsXHBYCGwosodt+TzK8kEezPoE7YnckHwhDmdOaXSUqLSIPKmsPKG6IEhcjEYTLScTyshYeXPajj4xIeuKI5ykzLl9eYwzan+fdUJQpIYxtyiWMhBJ/iex3okBU5EH6pguNPRIiWkClT4WQOWFCDxET3OozCCuLeix0C0PnM1ZLbdpRkDKX64Ug7h6LQq2HCGkcQBJdL5lRduIj8GlSRQsvqw1orJ2cADufWQSQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcU75L4NhYOOqpBJVd+2XoryhV9nYIl5d1UbdDMYNbQ=;
 b=LgymLp+h5XtN4LJNxtXOtL+2WHzp2F+klbFNo0+UwiLtjS2YzybJ7rqGK3cjdp7YQk5iwlLa17UCi26tLv1nl9oyWs1xMSbsOq9hNmus7/uXLbSdRVTnAGxhPtZtWLONfkdSRFYnlW5UrQDchQw8FFUFOvvb7ZDH7Pu4VODhGu7AXLHTysOzDzomduzcOG3dwBzJGGUTIuQXLQi03cZT1vNzjGHsIysU6T722YjtwQahg4mL7/u5+wOSy0P8684XYCKlVdE1E5R1fvUrHQlp0nRagNX8L4G7Qy5ktTPDFs3A20JZzryliOJOiAnbxhC43GkA8141PCHXu37hwdXYFw==
Received: from SN7PR19MB6736.namprd19.prod.outlook.com (2603:10b6:806:263::12)
 by PH0PR19MB5129.namprd19.prod.outlook.com (2603:10b6:510:97::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:56:09 +0000
Received: from SN7PR19MB6736.namprd19.prod.outlook.com
 ([fe80::4b6c:b84f:b71c:d0a]) by SN7PR19MB6736.namprd19.prod.outlook.com
 ([fe80::4b6c:b84f:b71c:d0a%3]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 07:56:09 +0000
Message-ID:
 <SN7PR19MB6736BB58C4F6E648CB3910949DF72@SN7PR19MB6736.namprd19.prod.outlook.com>
Date: Tue, 30 Jun 2026 11:55:54 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] dt-bindings: net: bluetooth: Document Qualcomm
 IPQ5018 Bluetooth controller
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulfh@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Johannes Berg
 <johannes@sipsolutions.net>, Jeff Johnson <jjohnson@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
 Rocky Liao <quic_rjliao@quicinc.com>, Saravana Kannan
 <saravanak@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath10k@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-remoteproc@vger.kernel.org
References: <20260629-ipq5018-bluetooth-v2-0-02770f03b6bb@outlook.com>
 <20260629-ipq5018-bluetooth-v2-1-02770f03b6bb@outlook.com>
 <20260630-wondrous-lean-stoat-be0b9a@quoll>
 <SN7PR19MB67361ED99501853D6BD968E69DF72@SN7PR19MB6736.namprd19.prod.outlook.com>
 <ccbd320f-5a17-45f3-96cf-3fa0c9bd1e8f@kernel.org>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <ccbd320f-5a17-45f3-96cf-3fa0c9bd1e8f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0010.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:26::16) To SN7PR19MB6736.namprd19.prod.outlook.com
 (2603:10b6:806:263::12)
X-Microsoft-Original-Message-ID:
 <2268b3c6-6723-46ff-9ec5-4834ef6a1194@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR19MB6736:EE_|PH0PR19MB5129:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a2a74d7-5785-4a63-e70a-08ded67d0bcc
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwUXBahuwteIkQeW30lJPuxOInnodx1UWtcjPExcipIPL7OdG3FFcmWfddTO34i850KWHEjmLS+Iwoi11fMyZRd7VfNaFJyglxLmbvHWrXho3u4xt3TPxjFLM4pwgHDB7tbq27fr0+NdiveNVTbF3lB6KMPZ7VSrOxQy2R7iPsrINwumXW5RtN8i+O6Rhd2jZJhP7Ie/ErBLLrvzr32QbcBK7emqApROqyXt3UraOjgT8fFvYwxTEZCq0clQz+rkwEbepgUr9l7i+gJvE12xuvwjcGDbNlfa80i1Z9on+zLCgxAUvM/r2aRb5HMVVrozyaRNF004djosvaQI4ForwDQHUyxhsA+o90gqvWLHCt9NPbe03KteZWR5MCqmuXHAuk7xfzV1VKuU/Pci1/i/lcgpbIypQPGPlR2sN7fpwGDKSWISjjQzXddwKsuFJ/QCodfK7AgeGR5eWxHaxBMRvKiY6CGerUJrvFLvLSwZjQBgsmD/EKL+IiovTuCG5zFBHno5S9BHi2RWaxyvL7mt4bStcjQMVAO20KDRnXOdCL2K6QDHQtg7Z4RD+JGZ5jqLBD0xDa7NSJeMrhPtt7bvuNCy2NRABabX88+3Lb6VWkvSns2FAXnwFFtfc5gcR7Q5yn59K0TTg8j67VI76c1Lelwb/UtsyWffE+jKceK+dNOaX7K1oatzg1TWlgs1wHwprGYi+IHmGMd3Ov/dOmpoOzD1iz6qRd1pI/QULTK9d+djcB312smYvUyv121K3kZaz0c=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|51005399006|15080799012|19110799012|23021999003|8060799015|24021099003|37011999003|5072599009|25010399006|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aE5iMDlzVFAwNFNXMUwrZld6K2xNVFh6TjZ5R29UN01BVzFjd3FSWkVyRFBL?=
 =?utf-8?B?QnozaVpPaGNmeHArYWxhZDBneVFkMFFUSzU2bnJTemZoRElFUTdzRDZjSmJj?=
 =?utf-8?B?SkRBSGZvRjdsNmE1TUJSTkgxSGpMUStkUUZieWFYNWZ3UEpGNUJmTi9TQU1t?=
 =?utf-8?B?Znl4cUtCVVZPTGNEL1NHdGtDWHFvM0drRnNZVm4zbTJtNEViajFuOThNS3h0?=
 =?utf-8?B?M29xbjlHWmpXQlMvU0pLdXc2Y1ZVa0l4R2UwbUFDWHJibGxzcjZwSnhrS0x5?=
 =?utf-8?B?RExJcThsNCt2V1lEd0J4dCs3YmRmTUw2dzFqVHJSdkFUQ2VEMDNNUXI5bmND?=
 =?utf-8?B?TWN5MGpuQUxPUmFsdERzaklKejRxa2VaMUpIMjVxSmYvZmpvUjdQOVh2NVBH?=
 =?utf-8?B?eVpzTTkrYUJkU1VMc2ZPMGhTaTVQV2lRL25FN1E0cVdrc3BPNW5xUDJoS2hX?=
 =?utf-8?B?a3haRWYvZDQwNmlkNkhRZzJpcm9JUFZQOFo5anBNUTBDYW1Mb2xFL3IwVytR?=
 =?utf-8?B?Q2ljQ2Nka0NxZnVueDJhY2hVY0VwRjg1U2xabUg4bXE3UVVTclNJYUlYcTFU?=
 =?utf-8?B?NGlidEtvWUFoVjdhUCt1Tng0K0JMOVExTFlXSHZjbGxydHQ1MW0ySUFXMStU?=
 =?utf-8?B?Y2g1bEtOdEc4Zkgrd1NQM3VOckwvRHRsa2VvN2hiY2s1SVh1WlJQa1FlNWE4?=
 =?utf-8?B?Njl3S09oQnF5N3piNmlvc0pzejBzVG9UTlpwcjVpUWpMQnNpclIxWGpGVXUz?=
 =?utf-8?B?NndpdWZaRmd5WGRsZG5sQVVCZEI3Y214S3E4UFdGa0xBekovQXI4ajFnSFR3?=
 =?utf-8?B?NSs4dXVQSjdrV0tYWTFLaGViS1RWZkZtNUVsY1RPQkcvaCs1bEZJYjlYc1Ro?=
 =?utf-8?B?bGwvWE1lWWpFUWF0Q00wUXRWY0xDRUJUaEcySGJNa3Y2RDF0RTVpTHYxaE9t?=
 =?utf-8?B?S0pFMVZKR0JNa2tteE5DSXRVRjM4RElkVitLVUxWb1ljOEduMjI3b3lJRkVi?=
 =?utf-8?B?QW9ONDVvWHlrY0Z3K1F5dlFsZFhLMHhPMlNJdDEwYUV6ZjlweGFESmtRa21F?=
 =?utf-8?B?MVVGRGtUMDdDTUtMTzdydXFJN0xnRXRXaXFUWFRGdUI0cUpZVDFxNEd1UTdF?=
 =?utf-8?B?bXdEYVl2RFk0cThDdDZJQ0VuU2lndCs1RzhoYitNK0RZU002Z0pSbUxqbENT?=
 =?utf-8?B?aFppNGtJSHRJaDNNL3BveVV6MGdPaUM1MHkxaW1yQWRCK1hmbGs0RjE4cER0?=
 =?utf-8?B?R1RjU1pFZVNjb1RPZ2Q5QWlNV3BsVUV2QjIwTndmTS85R1lRbjdxWVBkbElq?=
 =?utf-8?Q?dnlfgIId0yX3oD1FZp2kc4MuX6kH54E1p7?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ck9TYnhIc0N3bERialkvWWFmVncyYVdPRlRyc3MzVWhneVFPSE1VVitiZjEz?=
 =?utf-8?B?WEFlUkI2a0NuRDVtKytrcFNkalN1SUUrSXp3dVlDVVRVd3VVcjRHbDZyNmNn?=
 =?utf-8?B?Vmh6b1NiSk5wUERDU3VMdjZ6WFM1QjU2NkExenNSNExvRjFDcW16ZTI3bGxW?=
 =?utf-8?B?WDkraGxuUkYvbDVSeU5aekM2SU5LNnZuc0ozc2tORXdIZGRPU0dHMG5sKzVr?=
 =?utf-8?B?anAxTjMzQ2VTdndWOVduOXNHYkltN291enNYcUFZVGFYWEdMZWJ1L3hxbm9I?=
 =?utf-8?B?ODFBNThzR0Iwa0ptYnlvVjAyTXpFTG5qaHNzVDgzZVplZFZaU044elE0Zi9N?=
 =?utf-8?B?MysvWjk0eEdJYWJaYmN1MEhrM3B0WjcyQXROMEZnY0hPWU1Ib3FTY24raEt4?=
 =?utf-8?B?NjVVZk43OHZINFRtQ2huUVFLZFhGYzV2VTRlMU9JQjhBRHhwWnB6SGtkUzJx?=
 =?utf-8?B?UklrRS82SHp4WlBVbjBseFRobWdscnM3QkE0MjMvR1o3K3BQNmNMaWdUTWtJ?=
 =?utf-8?B?UU1mUTA4R0lvYnNZTWFudTdBdXlmb1Jmd1cxdDVmVUk4THFwLzFhOURNdmpG?=
 =?utf-8?B?eDIxM1ZpOHQrcFA3TDJlVHdNVUNFS2NQczdhb0JPK01odW5Ma3VialVhR09O?=
 =?utf-8?B?aGdXbUVaeDZvWmdVMnczUWxMbHdpalBqTUVKdlRkQ2NvVWdNUGdaajlGcmZ4?=
 =?utf-8?B?aHJXZDZRK3dkd0h5QmtEYjFMTks2dmpuYjhNK0hUUmFndTBzZDJpU250ZnZ2?=
 =?utf-8?B?WEE3VW5lT2NnMTlWTGlnN3BsRVZIcExxSXEyZUtKajd0T1BJVDJPTlAyQmhi?=
 =?utf-8?B?T1d4RkVRVkNaYVljaWVGK2FvenFHcGoyUC9wL0hWVXc2UFZjbXN5WTBrcE1s?=
 =?utf-8?B?ajVJQm1nb0tIWWg1QkxGZk9EMjhzZU1lZGZuMGgxNWo5bHhnRmFySWtvUmp2?=
 =?utf-8?B?S2VBSHNSUmg2Yk50eHR3enNXS25iWjdQYUhlTVM3T1FiL2dXbkVSR2s3RmZu?=
 =?utf-8?B?c0p0bEFaN2Z5aWs0ODkzdGZmTXg2d3BISHFlK2Rvb0UwK1NRQ0E0MlFFWWlt?=
 =?utf-8?B?bGNnakN0THJnL2hZMnFWSzNtWlcxSXpjV2RERGR2TW9tNHBOTVZrSWs3Wmcw?=
 =?utf-8?B?N0dhQVpHZ2VDVG9zWFJ1TjlsbmhyM0IxL2RPWHJzR01YbG5seEY2WjA1aUUr?=
 =?utf-8?B?Y2g1NkRZVnE0N2hMNzVGTTFqSldXQzRzS0RXNEV2ZnlTbWdQWDYvL2tMcDNP?=
 =?utf-8?B?aHpuSHV4RkV2RG11SXN6VFJKSWVMWHVMc0VoOWI3TkEyb2pSMTA3WUZUYlAr?=
 =?utf-8?B?em4xQVdHK2ZETG84UFpVZ3FMZktRaGRJWS9SYXZkQlMvRHFycTdsbDM1RDdy?=
 =?utf-8?B?VUQ3bzJFUUh4ZmxYYkZjYTFlQUNDSTNQeHI0ZU5DUWIvNnlzZ2hqWnRaWlRP?=
 =?utf-8?B?OFdTK0ZTLzlDWFRPcWY5bUJjL214Wms4WDU2WEVmaGx5Y295dHkyY0I3Q0Qy?=
 =?utf-8?B?STBndEpkQmtUeUsxTEhPNmtEbXJaOUlsTXJCaS9LQ0dpNlYxT1JIZWdNc1Jo?=
 =?utf-8?B?VmdkSFFIanpvcGt2NmVXS1QyZVg0TndLelpTc2hTbmMwQS9GZTRGQitrUXd2?=
 =?utf-8?B?WlZqYi9tSDZmNXdCWTQ0SitmREY0Q09sN2s3VHBWWlNqRFM2Kzk3c3ZONDl1?=
 =?utf-8?B?ZkxFbFRPUVNqRXJXZWFrTWRLQUt2b05VOTlYTklsb3Q2eG00bjA5RHJCRlFz?=
 =?utf-8?B?b1RnbGxQS3BhcWlTdWxRejhyZ2pRZzVHSlgzZ2J4SjQ4TmZmVmo3VGUxb0Q4?=
 =?utf-8?B?eHhWRE9mamZtQ0dqSEUzSFZDWTZoUTlxVXFlTlpHTlZ3OW5WSzB5ajQ4czhG?=
 =?utf-8?B?RGlueHpMQkFxblhlTjdkWFQva0p3c25FSXZkZS80R0d0cUE9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2a74d7-5785-4a63-e70a-08ded67d0bcc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR19MB6736.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:56:09.4689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB5129
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:axboe@kernel.dk,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:saravanak@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:mathieu.poirier@linaro.org,m:p.zabel@pengutronix.de,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-arm-msm@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-remoteproc@vger.kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[george.moussalem@outlook.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FORGED_MUA_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38338-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,pengutronix.de,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[george.moussalem@outlook.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,outlook.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,SN7PR19MB6736.namprd19.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E61A06E1812

On 6/30/26 11:40, Krzysztof Kozlowski wrote:
> On 30/06/2026 09:31, George Moussalem wrote:
>> On 6/30/26 11:15, Krzysztof Kozlowski wrote:
>>> On Mon, Jun 29, 2026 at 05:01:44PM +0400, George Moussalem wrote:
>>>> +unevaluatedProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
>>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>> +    #include <dt-bindings/reset/qcom,gcc-ipq5018.h>
>>>> +
>>>> +    bluetooth {
>>>
>>> Don't send new versions while discussion is still going. I need to
>>> repeat my question - what bus does that sit on?
>>>
>>> Device nodes represent real devices. Real devices sit on a bus, usually.
>>> Do you have here a bus?
>>
>> I'm afraid I don't have a definitive answer. Again, my understanding
>> based on downstream code is that the 'controller' is basically a Cortex
>> M0 processor running Bluetooth firmware connected to an RF. Data
>> transport is over a shared memory carveout with APPS signaling the
>> controller through writes to an IPC mailbox register, while the
>> controller has an interrupt line back to signal APPS.
> 
> So this looks like should be squashed into remoteproc node. There is no
> reason or no data to express it as two separate device nodes.

In this version, I've squashed them into one already but as a Bluetooth
controller as that's what the 'processor' is dedicated to, also in line
with Bjorn's guidance to manage the lifecycle of this processor and all
other resources in one. Kindly let me know if this approach is satisfactory.

> 
> Best regards,
> Krzysztof

Best regards,
George

