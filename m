Return-Path: <linux-wireless+bounces-38368-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8I5/F1OyQ2pVfQoAu9opvQ
	(envelope-from <linux-wireless+bounces-38368-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 14:10:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D25F6E4055
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 14:10:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=SjzYWe0q;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38368-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38368-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4BA1302EAAC
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 12:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56C3409639;
	Tue, 30 Jun 2026 12:09:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012052.outbound.protection.outlook.com [52.103.20.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7871E40863B;
	Tue, 30 Jun 2026 12:09:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782821389; cv=fail; b=u/1ymRvnqx8T6dXdVPerLGEG/KnNHbNHu/Wn1LYvS/cDAriZnjHCzVc6U7v8HdSx3DXx0EQ7zm1BVjyEWE+0wA4O4H4KRbV96RSEXgWDGy5ZVHCQXQOa3yL21ilwLB3f+boTkcP1m5qgV70XB8/bNz0c/p7Rf/rHj76T42QSrx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782821389; c=relaxed/simple;
	bh=IMTY6yWQWwaHu9EgYr0iKXym6+K76s31hN1KGbUERYc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cVvCNMpjcsoOMkRvIcviYHIiE1sjTxDcyMBy2W8Wfnn3fAyourUDIqXUYI8wwmencJmjRWN9BTDxOOE9b6VH77kqOc9wh/b4YI+Z4mbLPvTGft+/2WuIk6n9p2bBZGEHW1+D+gWew76lWz4rO+MPmiHRC0LK0BNE54b6Txw+/Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SjzYWe0q; arc=fail smtp.client-ip=52.103.20.52
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O35n1wRQ+apOh6RjcSglRsOyJBhMvYEmERNORLIP4tGP3V+FznbK4ZM6jktin5cF70A4T5tupzBfhAw1Q8McCTXqC1RWX50/twC7UPRoGCNqg3eH3zuVWJnvhD38wBck2jfVnfrqezLWUmK76yCnGvTv2LENX1onQQbCnDowferMnW666GT0Wu+UZ7ueLLKOxpIAl8T315uDUGwHmh+TMmZaeXL4WqNkVaNqBkp6WrKbrDlZgsdgTHDWKjPYRoo4U5nDOg3Jkeu98lL8s4PN+JUOjeZxl9CSslQmtALsth/xlm952kp9rwEbHchzECrNfxYDi64SQaMVBMwFd78bzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDvbpBTyDH106Gqr0tdY90Kx4l3DLCU9qprpFo9uVWc=;
 b=MaOCc2RFLt5yuPOWrY4FGME20q4qtbpkyWdzfNUG6UHfcTlfnHx34OwLomIvgCxBQQoleRJMpc4QZf/h2yLJeOcmt88muZo5+s51oFqOeF3TSOdNc8gVdBuEVvxOIGmtZL+T7MCQ79a6xOTXsNoUKvGXUWtyj5Ke2pXF7z45NnJLKA2Fbk6td26wxkO9AKKwi28SeklDrpXoWbeIfGsKwdM8PCEWKVll8LKkR7C8LxkcA7e/VEToISQxBhUiUd/+54Ml/z1hphaKCspn7ulA4dOitG72RlA528WzEp87/xiHnJq8DFmaDoNUuZvP/+R1WNSUun7EOuMe+CFVweO2lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDvbpBTyDH106Gqr0tdY90Kx4l3DLCU9qprpFo9uVWc=;
 b=SjzYWe0qhQON6jzF3Q9KDfnOviZV3/Yb8oPho/i25RKyAqd1AmYOGCRQhJnvvMQCDLZDGvPZZHWjqBhhLFEc6O+pATBVCAizMF0s4X6uBDMpBXUJxVal7e7wHk1Exxbe2AsvgAnjBk2XaAfs1ykgsgIX10RTpvUzLtnyNPGtLdKru6iw7CVNM5H6dRhXtsHnMIOHmh26Zq6zOABb0xYvEQupw2E58zfAKjs0Dycc7mj90/4Z4xllHHodH2HEVrUZIO33bg1VLFE8rQzNcD8ccH4iDdrEFitDWLCHZxyiiBjE+i+uTHh0ceyn6z7ByGy2JjKQk+oRiftHZrD/ljOvGg==
Received: from SN7PR19MB6736.namprd19.prod.outlook.com (2603:10b6:806:263::12)
 by CY5PR19MB6493.namprd19.prod.outlook.com (2603:10b6:930:3b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 12:09:45 +0000
Received: from SN7PR19MB6736.namprd19.prod.outlook.com
 ([fe80::4b6c:b84f:b71c:d0a]) by SN7PR19MB6736.namprd19.prod.outlook.com
 ([fe80::4b6c:b84f:b71c:d0a%3]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 12:09:44 +0000
Message-ID:
 <SN7PR19MB6736F8FEB36D52E867C000E29DF72@SN7PR19MB6736.namprd19.prod.outlook.com>
Date: Tue, 30 Jun 2026 16:09:29 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: ipq5018: add nodes required for
 Bluetooth support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulfh@kernel.org>,
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
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20260629-ipq5018-bluetooth-v2-0-02770f03b6bb@outlook.com>
 <20260629-ipq5018-bluetooth-v2-5-02770f03b6bb@outlook.com>
 <f3c79cb4-02eb-4e4b-b5b4-9732876c075c@oss.qualcomm.com>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <f3c79cb4-02eb-4e4b-b5b4-9732876c075c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0276.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::11) To SN7PR19MB6736.namprd19.prod.outlook.com
 (2603:10b6:806:263::12)
X-Microsoft-Original-Message-ID:
 <72550eb8-e4e9-495d-8018-0af869f79fe5@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR19MB6736:EE_|CY5PR19MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e293b77-7db4-4683-e801-08ded6a07811
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwUXBahuwteIkQeW30lJPuxOacXavKdOD3+SqXxZJDos7OK6ihiv8GxSdOw1DbMqNlD5RTnKSV5N/6Islxf4+fKft8eyTsBPIv1KCANIOcshQaqkOZQayt7AR5W/S7twAmMozcJTEFcZT/973fl4fz4CfoRYgpr3WHU7ksbPy7tGHE40PKZ1AoJ9GABOMQ5WXUVpOVg/Jtv0xfhmknxZyS54V0gnPCe4UEwpsVYW0zKTSPo9FUcsCxdkqJ+3OEl3p6PSosng72yHvCy2XuXS1O4AG9HOEi/E05oW8KM/kvD/lKWB8TscydZ/ur/BV7JWPuBvhpfrtpzUGnGuZBir2GWpgpBg2tdk/sQNfXC8mEo864aGKSE0UUdIUHG1INN8NIf8hhaKumxFvYXVjAYmUUrCyh1HRacZfKRdHmbGA1bNDEbIOTGlDv+X0kqXKmWUm4rIcegWr1Tf1l3s14Bynp3XRy8DtoNZp71o/Ixn7DJlUf8bbH+YZAAsPNG/YrWKoS5lP66CLF3egs3+JmY0uB1RgVsA4DdrPsdIL3Vj6W5XIClwYmhlbkFJ77WuHUFhx0TMXGvrtL3eJmghb7U85wvb3pF6ma9GgaZyIE8ldWlWhEKPYmh+JEGtIgkWJywZTSuUgYSgodHujIiTm1kuBx6c8t26fojrC2+qE/1NpX5GoENlgD4TDqTdFRp9z8yzkFzC1hZOWar/+I0XCuiytIBEa7yis57YcLpH/THjtI07qAvuyBonCPMT88bfhdutOqA=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25010399006|5072599009|8060799015|15080799012|19110799012|37011999003|23021999003|12121999013|51005399006|6090799003|41001999006|24021099003|40105399003|4302099013|3412199025|440099028|1602099012|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTJqT1NONVVubE5QTXdDRTcxUEdrTFpaQWhvcFNVM1Q5VVhrMzlWSDdsWU9P?=
 =?utf-8?B?OFJONTF6Q2JsVHpwQ1FTZ29INjBRcXNvR1BFSU1CQ1FjQnlhZVpJTVlkT282?=
 =?utf-8?B?RENpM0Z5Y1JuNHg5aFNyTlhIaTZ0WDdJdjV1R29oMXhZME1nd2dZclB0S2R6?=
 =?utf-8?B?bHlwdkJ3UWFEMkNOeUFIOVdRQkxYRXpWeXV6VEJOajJPRmwrbkF2cGhPMnZB?=
 =?utf-8?B?Zit5bW9CY3dMeG53VlZKcEZzU3ZuMWE5anFmSVlUcU1UaGxVS0o5V3JvRklV?=
 =?utf-8?B?N1QwajBkYVQzNThoYTg5YTBvejFlV3pBdnA4dWZVd1hRQ1AwYWZkeDhpOGRE?=
 =?utf-8?B?TEt2cEE1ZEovNVZoaDVJUWZUdThwRGRnaVFtcWNSRG9tRFF2N3JKVGgvd1V2?=
 =?utf-8?B?L3lYS2M4YjNDSWZSdUF1SDlGMjg2d0hEK1BPOXNKN0RGQWF0NExwWjdTQ2hS?=
 =?utf-8?B?UFp1dTlrbVdkU0ZUbnowZ2xMR1Y2MzdYZFZFTE1TdGVBV3JvMW9OeGhNbjAr?=
 =?utf-8?B?QTBud29HY1B5bXBKeWpmaHArT1NnWFkrc3ZlZWNTMGQyWnY0TzlIOE1UMk5Z?=
 =?utf-8?B?U2d2UnFVamY4Q1BLeUxuUDE4UE9Ub0tKQjZkMysvOVM4TUdXTEdDUUVibnlj?=
 =?utf-8?B?ZXhOVTFGdmpUeUJQc29nbDQzSStjK0l4YVlHdXRpVHQyWTJhYUxtdGJhbk51?=
 =?utf-8?B?TkdtTWVOUUo0UnBYd0ZmR2p3dithZVFwTU5nak1VdnFzZCt5TEFwNlpibG9P?=
 =?utf-8?B?YmNEamVzdkFWZ3krWTU3VEZ0OHFoaTRWZGMvV3gwaE1VZTFxMnlHTkVRTHlL?=
 =?utf-8?B?aDgybzFVY2V6WVR4UmllTTJjNGNyd1VQQUdxMDd3UUhaWG14WHBXYmJXOElE?=
 =?utf-8?B?OHc3T0JHSTE0ZEVjZXFnd1J1NS82eFpCR3N1SUtISVVZMEpTY1lmS2x6MHRS?=
 =?utf-8?B?amdVcGxWMmplUWxmUHNpR1VKQmo0Vk1CL2ZDYmdkQUlneEMvZjd0Vzh5VDF0?=
 =?utf-8?B?MENvVVFuMzJpNmpGM3lFQmNDNnZLOStPdkhKb09KQ0s1VUo1OVdFWDB5V1Nz?=
 =?utf-8?B?bzBYZWw0eUJtOUJyUkdja24rRUc1M3U3Sksva1VpYy9pR1ZhdGJDOVhDR09v?=
 =?utf-8?B?N2pEQWV5bnZ0MUMxVUhWbU5XZE00K0VHYW8xTnpyalhCTFROY0dJSExtT1Vx?=
 =?utf-8?B?ajNaZG9Fd3dFK1lsQkJRU2dkWUR0NjdhcHlnUmxzVTl0RHI0OHVnWGpkcEEx?=
 =?utf-8?B?RXd6Y2NtbmhDWWZ1a3lXalJLNVk4MmpjbzR3bVM1ZHdsbGNCNElQa0hZQ2t2?=
 =?utf-8?B?QmMzVXRCY3RVUGtqVmdxbTRpYmVFN09GS3JtWmNZNXFIWk00R1p0cWtwWUwr?=
 =?utf-8?B?WDhkdmNCZHBCYXd0M1ZEZzE3Tkc5b2UvKzVLRWcyamZCbmpTRS9lMTlIaUlp?=
 =?utf-8?B?MUNCM1UrdDVwVllCQWpGSXF4a1o1SEtLbUZtUDdKK2I1eHM1SVVKUE1HVFRV?=
 =?utf-8?B?UUF3dHRBc3FMcnVWTFNlbEsybjZwbU9NOHRnWkl6NE9DR3VzMytRZmdFZnB2?=
 =?utf-8?Q?OKu0peqJnto2+QS/xGNmrVRlI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3ZBakxEWEkvYk84Q0lqR2JUNUlmRXZITkVJcW5yY08vQjFVRjFrc2Zic0Zn?=
 =?utf-8?B?RWhaQ3hwN3FnKzdKNDRTMWJiMXgrQVZGSmlGclh3ZGl2d2JYblQ2QmpPQWV0?=
 =?utf-8?B?dnBpbmo2bjJOUTgvZTd1YWRvV0w1c3Rwc2U3RmJmTERiVExhVzFFWlMrVmR2?=
 =?utf-8?B?NFVhZ3dML1E5OEd5M3BLYU9xcEIvRFJCaXNzanFoWW5MbWZzU2lmaFRFeFNJ?=
 =?utf-8?B?SzdleHZkbVdVNlBDSVBLckVucW10cTFhWStwVVpkcUlObU9GVml6UWNLK3ND?=
 =?utf-8?B?R3BYTUR5eFdocjJWcm96RXZwdWZDN1BuUXJuZy8xV0MvTWMvYjBsR3lCcUl6?=
 =?utf-8?B?VGhzbVhZU25mQ29sRlNITHZxeW9LMDVkYjNIRHpEcGVIZEx5YXhmc3FDREl6?=
 =?utf-8?B?YldlbHU3VnVoOHRCK3lOTFh2MFU1d0hHR2ZqUU9HNGJQNzhQN3lYMEh5dUUw?=
 =?utf-8?B?Q3ZEYWVQenpVS0pvWmNsTHNGZlN3N2poam5uaEhXb1g0bzdCdWtxRVZ0UC9m?=
 =?utf-8?B?eEd5Uit2T3REeVlob3VpS3JDZlExZ01xSHZBdllqOTZWSjM2QWtqaEZCcFZs?=
 =?utf-8?B?VURMcnpxNmhmVUFyUm1VdFhvMkhTOFl2U05jTVRxMHJ4SzNETlp5VTZCR1ho?=
 =?utf-8?B?c2I1eFV3akJKbWNpZklqZUxrRWNEL3UrVVNVbElhR2pvRzd4TWdNeVVsV2l4?=
 =?utf-8?B?ay9BMkVneU1YR3VXZEhwSmc3eWU0YUlLV29ZcnFaYUEwMjNiOVEwTUd0c3pE?=
 =?utf-8?B?UkhGZENXYTBGYmFHK0ZrcERaOTdjZUQ3dDJ4OHU1TXVvSTZPd2N4UU9Hck54?=
 =?utf-8?B?NjVJTHk2RkNSUzF5NlFsNjNnM1VNNDdmbUhZZkx1aVc1QW1ROUJkdzRMSmNl?=
 =?utf-8?B?cXdMUGsyZ0hBVE05OWYzSE1uYkNhbUFDem8zR0xUdFJoeU1tRngycE0ybUps?=
 =?utf-8?B?Wlo4UzJ6RmFLbTJ1b0pOYXgwUytaa2JmMWJHZWIyWWRjZTBNSnVHODBhSGRu?=
 =?utf-8?B?bVFBTjQ4M1BnQzVuSXdjT201bk1ZbEtYMVVzemRDb1R6ajhhYUpnNGlQY0Jw?=
 =?utf-8?B?RVB2Vm1USWthN3Jod0Q1MGk3TVdpNlBvMWNqSDFVaTk5KzhDZi94THlzS1lt?=
 =?utf-8?B?WHNwNzhmRS9rWFkrWjJ3TmMzcWZVbThQU0pwU3VScHFGdDBsNVRnUURoRXhX?=
 =?utf-8?B?WG9wWWN1aUhwVmZXbXFrK29VNDNLQ2paOWtyaDVQcWtrZy9kSTNPRDRBWFdX?=
 =?utf-8?B?Zm9YMFRPZXV6VHNQZFJwOEhVVUFubkNwS3ZKRXFXdDNZbDV3V1RKMkxHMXV0?=
 =?utf-8?B?SG9GcEVNd2dBU21uTzBJcmREc0VXQ2ppeHdnN3JlMFFGNm83QytPUXF6cDFD?=
 =?utf-8?B?Q2tRc1IwUVl1UnJvb2g0Nnp1RkF0RGlMS0YwN2lYdDB0dVBxQTF0Z2tGVTgw?=
 =?utf-8?B?VjgvbEQxU1FYSlRiWnNJYkhWdkZlOXNGbkowVkxlbDIvclNlN25pOHZteWxL?=
 =?utf-8?B?WkZ3TFhtSDFVekh1T0dHUmh3QXVCL1l3NGNqRW5vZkNmNzRmckRGdnhLVmNk?=
 =?utf-8?B?RkJhczNnWUh6V0lTTDhrMzB0d2s1R2tSRkEvVVJLL0dQQVVtRzhwNkx2Vjhz?=
 =?utf-8?B?Vnl2SzRzczY4aHpMOE1ZbXVlUG45Y0JVekhyMHRIK2doR2c5MG5qQnZZVHRl?=
 =?utf-8?B?MjJEd1NSdWZqTVdzWVMzZDlDOW9kK1FKaWczODU2VDlpMUNwY1gwQWs1eXRF?=
 =?utf-8?B?UWtVSE5LQzB3U2E0NXRZQjhKanErN1RGdmJwR2F4K1FPUE5ncWVWcnUwNnFm?=
 =?utf-8?B?cFpndElLMnJpTEdmbG1GT1hnbFEwY3QzcVhQU25rRncxVGV0S21RcUVBSzk1?=
 =?utf-8?B?OGYreVc1aWpkUWJoRmNyZlFjUTlaK0IyMzBBeHJ6NzBMNXc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e293b77-7db4-4683-e801-08ded6a07811
X-MS-Exchange-CrossTenant-AuthSource: SN7PR19MB6736.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 12:09:44.0567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR19MB6493
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_MUA_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:konrad.dybcio@oss.qualcomm.com,m:axboe@kernel.dk,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:saravanak@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:mathieu.poirier@linaro.org,m:p.zabel@pengutronix.de,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-arm-msm@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-remoteproc@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[george.moussalem@outlook.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.dk,kernel.org,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,pengutronix.de];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38368-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,outlook.com:dkim,outlook.com:email,outlook.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D25F6E4055

On 6/30/26 15:40, Konrad Dybcio wrote:
> On 6/29/26 3:01 PM, George Moussalem via B4 Relay wrote:
>> From: George Moussalem <george.moussalem@outlook.com>
>>
>> Add nodes for the reserved memory carveout and Bluetooth.
>>
>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>> ---
>>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 25 ++++++++++++++++++++++++-
>>  1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> index 6f8004a22a1f..65a47ba7d3a3 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> @@ -17,6 +17,23 @@ / {
>>  	#address-cells = <2>;
>>  	#size-cells = <2>;
>>  
>> +	bluetooth: bluetooth {
>> +		compatible = "qcom,ipq5018-bt";
>> +
>> +		firmware-name = "qca/bt_fw_patch.mbn";
> 
> Is this fw vendor-signed?

I've just analyzed the mbn file (and the mdt + b0x files): it only
contains hashes for the mdt and b02 segments, no signature/certs at all.
I've used your pil squasher to create the mbn file. Here are the FW files:
https://github.com/georgemoussalem/openwrt/tree/ipq50xx-bluetooth/package/firmware/qca-bt-firmware/files

Perhaps you can double check?

> 
> Konrad

Best regards,
George

