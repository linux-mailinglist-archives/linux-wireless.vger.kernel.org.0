Return-Path: <linux-wireless+bounces-10592-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D5A93ED4A
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 08:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C3F1F219B3
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 06:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A1A78C8E;
	Mon, 29 Jul 2024 06:17:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2110.outbound.protection.outlook.com [40.107.117.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115E22F4A
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 06:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722233827; cv=fail; b=bFZ9ZYIuFHT65lExk6LNF2bFBjLlyTZKHDWdvRjclR64YFcA7F5O0dVM0pQ2XFXnwflDTxrOnofsozjvz3moWsKYo6T8Qlnv/o5B2fDJoWAw0Wtrd8ja/i7Nmld/jHlc3C2Wx+8dq+uiUGm691F/e7a6HlbnODlm6h3ywaUBNjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722233827; c=relaxed/simple;
	bh=rT9c7H3dWouqXYM+TsX4eIWeSPCJBEf9zwGfHQLcgeg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bkiZKiQboA8ylnrkO8IzHj50WW117XWP2JJA9oY6Y46LQ4WNiNDry/WizohT0apCziIsnndO40QFNbpkT2m97lUyGtETBxHMJZo52TUQcSbTH7zCFM5JwstL+lumjrVxqHCG3iHEpsAxCRjGcUEFvsrKxQq7I/Y72BKBMbCFJ+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJ1qfRsfzTAOHY+L+iLfJvngYIemqtyyy8uKKxCNH6EaoTXTtIikdFt1ImC6y4suX6ccA5BeYdanEZqp0SmX38EyfiMdzkH8bod4scxx5wkypbnL5WZoSRGYsgSe875IyVDhgKceMrNGmExOclblsd/xrU7QtGsrSxINRUN0E7x5P7/Db7EH4SSSH8nMkh1O4Tafa3bt4OpJNa/+YB7dWkhvcxWLHe0sqqqtr+qsCbMYU/1+YQZGQE8tbIy5oC/6A4MEUis4xlncdcUlK5yJECud0hTCLhrCVFBwztSlhxgMjQ3mUxvqlOA6wiPCoMDjvV88rXbVpJJRCbKKxggoaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eV7iJ2dM5fmBVHrH3CC6eve9oMqMxmnlRvuqXMiyzoE=;
 b=b9ltka+IZ2HMwAU5fF1ZkINzYjZQ77DWzgKoZocDpxdM2ORN9bxbu/QjlhjSkf/qRLleOBfCvl0kmMOXtmlbQrchCMLpb3q5Y/sEJ7yBNqgCnyrGbA/PDhSi5I0qQM5CWyEjmyerxz6omHOovylj0wNwhhCYKRPI8fD7ATHsz0MSNcfm3Wm7Fzj+aqBepmDXwXb3esP2435e2D2wBpTbrxqJuEJ34wapLsuQDtiufA9wMvlhKDyzkhGwYKe007ZI0RUWYuOZbpTvbQJudC4KSpOIlEvt4ixe3pl6jsO3aR5npWHMSqok3arf2HOGwWPZUKmVXzY88dQneRsJtp9Yiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by JH0PR03MB7976.apcprd03.prod.outlook.com (2603:1096:990:2f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Mon, 29 Jul
 2024 06:17:01 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7784.020; Mon, 29 Jul 2024
 06:17:01 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>
Subject: Re: [RFT v2] wifi: brcmfmac: add flag for random seed during firmware
 download
Thread-Topic: [RFT v2] wifi: brcmfmac: add flag for random seed during
 firmware download
Thread-Index: AQHa4SXW/1EHZWDHk0CUxxPx7MBqPbINOn/O
Date: Mon, 29 Jul 2024 06:17:01 +0000
Message-ID:
 <TYZPR03MB700147CA6C80F34B8E3D5CC280B72@TYZPR03MB7001.apcprd03.prod.outlook.com>
References: <20240728193904.35820-1-arend.vanspriel@broadcom.com>
In-Reply-To: <20240728193904.35820-1-arend.vanspriel@broadcom.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7001:EE_|JH0PR03MB7976:EE_
x-ms-office365-filtering-correlation-id: 0de2b64a-53df-4e34-03bd-08dcaf960ef3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?XCeFeRO7GLf5ldx9HwR0CA44DqNxZmZRAHZZPqPU/Py1aq/mMvp20+RWpF?=
 =?iso-8859-1?Q?vULtdkrWODoNpJdHIM66wc5M7+clttBdCKVq+NwIlpqAWgqgh3t5QiwxOy?=
 =?iso-8859-1?Q?jb5KAtrvg66U7zO7lGRs4F30R4GTq3MQT4gqwLEEthpPPG5q/jO7m7x+k+?=
 =?iso-8859-1?Q?cnNFYdDLRSwpLpL/jlDZHh6zrB+jycEo0WAGIpSv8d7BasFgc+TXUddXA4?=
 =?iso-8859-1?Q?/DjHyq/63V02PyPBMxH32K1K1m758An60FC8dcDm9o+U+xC6OLOSL7FhjX?=
 =?iso-8859-1?Q?6FXfR7e5edBmGu8+hvRUtQ+Id+rTw3EHlD2lMjlkQ57J4eb9nK1hD8I2+v?=
 =?iso-8859-1?Q?KXP4Ry6CwwGjecTgGWzqac+Twefril4BeGlOrtxvTNueBaqCawzNwF5ERv?=
 =?iso-8859-1?Q?xDuMbZcwQ8/m9rMSTlj+pSBx06BSvxFQ2ec/De7pA1gevEN0M2/EIC6wB+?=
 =?iso-8859-1?Q?TJ4XWR6cTzW/I+cSTz8VjdVGeo7gYrwnbIMVM29nOlqszP8IIgbHvKNXOi?=
 =?iso-8859-1?Q?ciqjeCFfTuvRPMnk9owFQPnBVk0XD7S3hXcaKLQPVm+p3r6aT1QTFHFX2A?=
 =?iso-8859-1?Q?26lkCOsQXZG1tKT5N7Xfl8LTrbMNke3dxD5iVndoRproJA9gGkQfChBmzU?=
 =?iso-8859-1?Q?A4YmpObj4HFVrnZ0s69fezTonFQxg8CmcyguQJOrmOumzlhY3b+gS15KO5?=
 =?iso-8859-1?Q?pYHidgYNQLpn/5IufewoO+OMBHqlBf7pkgpemiLBA9DG6YFElPGm8xcHWL?=
 =?iso-8859-1?Q?c8LzSlxk3vdkyyh+mXXy6/Xh6FdxJB7SngTyom8GQImgPfNmNApx7Lj9lV?=
 =?iso-8859-1?Q?xshE7ssCxWCOryfHdqADhja8jLYELSIz2/A0LWsJZTWsSqvLC0rCYiRNok?=
 =?iso-8859-1?Q?1DmhL70PnPCQFPKrpKS5KukdLs6vvr3lhVH9Ycnfq7zay8SrclqKwWkFd+?=
 =?iso-8859-1?Q?JVn00GLx29I3e55zxnxvfsFOLfpdlbo537GChzsWY6+x8MySFd9JSI+6UB?=
 =?iso-8859-1?Q?XvMPMwZ3pCG+ZUuKncblGl7DPYkN6RdOxAsKWmPeq9B24iKcF0rQ0xj0uR?=
 =?iso-8859-1?Q?uEgVV1Y2GeB/gJHztpckKpAOfmpT+rfqoY/fOqXOReSeXBrmh+CvNWbAmb?=
 =?iso-8859-1?Q?Dr+PSuPUqn1JHgww/+xu8NoicBRVxoLpBUFnK9V9OFVcgZc980IZqjS2jC?=
 =?iso-8859-1?Q?NMEwzpyQagEx6HJgH26IZb5v0FOhCTWMVMyOYsKKh3MIz4gIPDYFpJXJoL?=
 =?iso-8859-1?Q?OSSzxsbKAK2qPVxDj3Uw8FPNeCAcEdhd+eIQYj0PUfXd/XESJ2PiSyF2bj?=
 =?iso-8859-1?Q?RmOpY/gglijIbOWujtBl1KBe/BtL/OP6mPImF8b/QA/pe2tAikT897gQQc?=
 =?iso-8859-1?Q?wfCeX1uvAu718Ng9i01/kvtuzAJR6KMcadM9n9pSrWuX7GQB9j8QdtU9DF?=
 =?iso-8859-1?Q?v9uQjKD7rudQarFZEeZK2FpEcNFX1alNcW7E9Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?igyWCsL6W6hb++8tWvu9TmbC4zPeN2GyVxxLSnjdsKUMHtONiteTHwWGsw?=
 =?iso-8859-1?Q?B5tmjKU4hQiLrYqD1sMUBol3ffteSmprOeQLYTPx0waLuOfo3Y1HYStPOC?=
 =?iso-8859-1?Q?4i0E2pBkf0a6v8Q8K00qQvpTlkyECPqwBiiLpOgNYVB2ECKsezuPnDCsqf?=
 =?iso-8859-1?Q?+vKmhEHXmeVX8WZOdg/XCNEc32L0kB4UyEMp1H+nUHAEdZ3SP6dJG1cAZf?=
 =?iso-8859-1?Q?Y5VUudK80x6EibmZG31MSq+r/jRdYLWQjA4OjRQsZlAbI0Vc/qd2xuvM9g?=
 =?iso-8859-1?Q?LrLz0P9R/L3Mndk60AXwODTgq8KcDtIdTNuHXnmi8zTAg4tQZck+NiZ8r0?=
 =?iso-8859-1?Q?l0aj2RcbThwnmyPlHpjAfltDR0PPtYa1T+RUULZR8YAxq/ZMYFfZ9iKb+v?=
 =?iso-8859-1?Q?rPq001Rztpa92sYPoU5acjSe7p/46cEZl/rZucC3OL2lH9vcnpxkLsFT3S?=
 =?iso-8859-1?Q?wnnR0NnmUz8OsbjtAJnk4B+zOJZVVRQhy3LQ7fWmolLYFNCWJMDF4FsGQm?=
 =?iso-8859-1?Q?F7GJkLUt99F5EFO1hEEa7jfkpCyYv3GDgqQtu8KHK5T/vm4Le+T1hBpTbF?=
 =?iso-8859-1?Q?rMfYX1y8KrP/0LEE2sJP+G9N4o7W5Ko5G/6b2HVC5VmqG4/weHkP3Gm5UY?=
 =?iso-8859-1?Q?x8dx7pk7j88Ir+POd3hzrL24dQtbWS6H8Hb8uLF4GpQUPK83p3kURHyNzf?=
 =?iso-8859-1?Q?SvmW6O6ddTymYAX6npK/Agbow71BS/HER8VBEK/d1LtZ0Y5kpQpEIKnGE8?=
 =?iso-8859-1?Q?CtbNdh1Lul2MsqkWz4fOCP684e7indX4wLKthexmWGuew87fxejmG5D7Kg?=
 =?iso-8859-1?Q?vtlyT92iMgsnAXxq2uK+on250GVNTGsbSO4oXPV8kj5iI2lZK2nYTMPIoj?=
 =?iso-8859-1?Q?xToUJ1oL3qg7c/q//M5qWHqROOWW6f9Adjyhns4FHSmTT/1zbGjU+I+oCp?=
 =?iso-8859-1?Q?t5HyHq64v1rEjqUw1iJ3L0fqjpbol9sE94DirJhPpYBDTI62jYNoXOpHHB?=
 =?iso-8859-1?Q?CTOionZXkJYIThNC8klmL+g2624qGAaIQvB6SJtdAokLiPjHQpuAm8ZTED?=
 =?iso-8859-1?Q?ZxxidL04Jkj8X6vP9EH5MNalhpl1Xf1NYUbkz9F/eb6eL0kSS6aSwVIoPg?=
 =?iso-8859-1?Q?pql/JJyi4xqDfGlxOJccirCFy17I5tNLoofGAld+2hnDWOWtOx+5ZWHPs/?=
 =?iso-8859-1?Q?Ys/M/OTthQzGGPXJFpGOr0kDSWcQRm+gpw777984tatc7jbCLElfACJkWr?=
 =?iso-8859-1?Q?E/pPQSv2dxSPizXIcSp2YN2/MKyVHSJLW97/qsylkS/n7+2yzEYPFABOSI?=
 =?iso-8859-1?Q?hZoPzXnLoVCiKmuemW5tMEo0EYJIv+t5f9khAimp6HK5XDWLgVegt+HS75?=
 =?iso-8859-1?Q?lzdDzYA5ew2WdcGSP8z37JaqIiv2szR8FZrepX9Ab4OX6jQhuAfp1DPjHD?=
 =?iso-8859-1?Q?Mcw49XXCv8MHgfPt7grSZXB5WgsGyn3Uh3p8N8y7k5bALU0AjNlpLzXOqV?=
 =?iso-8859-1?Q?zVZslwwc+ccDUeP6g1KN5LigXdJ4mdZuQDXltDV6usoTroXmzNrIF+fJqm?=
 =?iso-8859-1?Q?Aq3xBfXoKsWCPJzsDB5+GdfCH8+vWmE+Xhw71pgwqZl4miOoSs3olI3Q4k?=
 =?iso-8859-1?Q?xPzINagIZenv4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de2b64a-53df-4e34-03bd-08dcaf960ef3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 06:17:01.0066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3gHP9o0Ihj+O/XEV9Bv/aJS20SMTSNzXzjSi5PkrP15C9Ja0EdcexNZT3Yt7zL24HzmZUWjTm2lKH90aqLHrvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7976

Hi Arend, =0A=
Thanks for your patch. It works well.=0A=
=0A=
> +enum {=0A=
> +=A0=A0=A0=A0=A0=A0 BRCMF_DRVDATA_CYW,=0A=
> +=A0=A0=A0=A0=A0=A0 BRCMF_DRVDATA_BCA,=0A=
> +=A0=A0=A0=A0=A0=A0 BRCMF_DRVDATA_WCC,=0A=
> +=A0=A0=A0=A0=A0=A0 BRCMF_DRVDATA_WCC_SEED,=0A=
> +};=0A=
=0A=
I found that in drivers/net/wirless/broadcom/brcm80211/brcmfmac/bus.h has a=
lready prepared an enumeration like these.=0A=
enum brcmf_fwvendor {=0A=
	BRCMF_FWVENDOR_WCC,=0A=
	BRCMF_FWVENDOR_CYW,=0A=
	BRCMF_FWVENDOR_BCA,=0A=
	/* keep last */=0A=
	BRCMF_FWVENDOR_NUM,=0A=
	BRCMF_FWVENDOR_INVALID=0A=
};=0A=
So should we delete them? Because you also changed BRCMF_FWVENDOR_ to BRCMF=
_DRVDATA_=0A=
=0A=
---=0A=
Best Regards=0A=
Jacobe=0A=
=0A=
=0A=

