Return-Path: <linux-wireless+bounces-20324-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DB5A5F582
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 14:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C30307A5697
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 13:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F00263F2F;
	Thu, 13 Mar 2025 13:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JZpt71Ca"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010003.outbound.protection.outlook.com [52.103.66.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86AA1F1519;
	Thu, 13 Mar 2025 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871400; cv=fail; b=FCT6XbVYsZ86C2FgAChEpCkfQI2Ryo0DugFvfF5uxMhlK1sjUskAT0Pj2iGmi7UwIQVNxy46IYErxaGgpoqi864FWxKfkdKcEbPznbrmFJg8KvnT+sw/UhaRS2FyQbP4COUC74NwrH8DG/nP0kz0diY+ZETkvVaDqZGk1vK6iKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871400; c=relaxed/simple;
	bh=INJHbmHB1BWnxSW4CrEYIEz1idUK7v3XQ5sFnjqS//4=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YamaL6KqHZdhygKTxVUXS18ne32kgac3l6bJLG1OySbT40to6w8Uny5ufrIIiQyxxKjnU2ptnDO30GwJF6BDWl/lL0g4YldiC6i2E9nUVzE12pNfOpYv/yZ71ldtZZM7f8fQag9SIWmCZxO4aZGasOuI44S4DLStfo10jz8D4dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JZpt71Ca; arc=fail smtp.client-ip=52.103.66.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9e4YzB6B7jTSDcpZJVNMXNyOx3B/6roMbKHbD1nplbEfEBAw5O0wDFbYiRACG5FTDtd8Q8vRUOvTjKDcbSBMnprVVR5SkGTrAGtoXBi9aIFcA/lYKJcBVvnT3af1zBO8eOEoQ4jbzh+nNnoZxbjnXk9ICJ9Fp0Y6ChEaf1TQyhlYy77WW59Oru1ULcn/daHJ9GC9Fhwef8YSV0HMn9I6sK2/rK2u4unmmtwK/28Z1wY4AEZbkWtsOu27EeI8WWZIVE3X88JltYLXw1TUOTslsFDnc0WmpL9pFjxuN5Vv9aqG2LmxEBjvwl4ssg/cCzenvZDCdzfIrIDf2eu5EifZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INJHbmHB1BWnxSW4CrEYIEz1idUK7v3XQ5sFnjqS//4=;
 b=M0zZa0iDrNyqRg/YtkvYtKYQBnenEx5evdw1lvBtWuj2ZxqRzPLQA/qrazvZ/roXP57+ghtM8LJL59v9Xf7wUjdDuwB/FZg5rQGQBdme2M9MXkbFDRKCF+AMp1sll3CsQxcQ/115K7jb3HwKIP97+KioW/2gdptZkwp9vA5tAZz/Xp9eIWhuefY7x310wcVEMaJLcOHhu+Xs0F+dd/blYHejJoxfqNB2jZMwrP0xFtCyQqZ53hHUSTLLd/obFV9sMSvwJwAudzUHlOIKdOTHqZR+luzIPRHIoczDufv05pzIst3z9yF+eeVgQ/MCcUKff2XLDI2BiauEZ1Xg3YNlCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INJHbmHB1BWnxSW4CrEYIEz1idUK7v3XQ5sFnjqS//4=;
 b=JZpt71Ca6kc0q9AA4Z+JbHwp/IL4uAHGmPNVvTlEY4/M0cZgLra97MRmB06RPffwYHudr2QJeO/4i/p+1HXhg3Hw8U32B7inYq+3lxwI24Oaxh+9Bj3CezwYukHn47w2Aoz9oPJDjL5ARF5gDimuYtB+z6DWsRzHP+WaSdICAB6DjXL5cFpUt9Rqlu4jSrRcbEhTztUBuiZdvbvQCH5Ijeia0H2qt/MKFKCaXTDuujJyZDhxt2FMMdFC+jat8o3srQ1bSC2A0zjtEuMMXIL48Se5lTDhCn9hwaPqnsscQGG4aWet1WEtXXa5VpVH7QBnnaoQVZfCAKfXlhK1rMDh5w==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by OS3PR01MB9802.jpnprd01.prod.outlook.com (2603:1096:604:1ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 13:09:54 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 13:09:54 +0000
Message-ID:
 <TYCPR01MB8437B3AE3BABB36A78FE17D598D32@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Date: Thu, 13 Mar 2025 21:09:50 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>,
 Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: Re: [PATCH v1] mt76: mt7915: wed: find rx token by physical address
To: Felix Fietkau <nbd@nbd.name>, Ping-Ke Shih <pkshih@realtek.com>,
 "lorenzo@kernel.org" <lorenzo@kernel.org>,
 "ryder.lee@mediatek.com" <ryder.lee@mediatek.com>,
 "shayne.chen@mediatek.com" <shayne.chen@mediatek.com>,
 "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
References: <TYCPR01MB8437EE1595CD4AB581C006E898C62@TYCPR01MB8437.jpnprd01.prod.outlook.com>
 <TYCPR01MB843726907C170CFE2D3EB7BE98D12@TYCPR01MB8437.jpnprd01.prod.outlook.com>
 <e144d2ffe9924d81a7b60f38cdcf516a@realtek.com>
 <1c46870f-965b-4f70-a01b-adbcd60c2876@nbd.name>
 <TYCPR01MB843770121E6576BB3807CD0A98D32@TYCPR01MB8437.jpnprd01.prod.outlook.com>
 <0ab3fb92-b529-46a3-bc78-230eaf4ae805@nbd.name>
From: Shengyu Qu <wiagn233@outlook.com>
Content-Language: en-US
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <0ab3fb92-b529-46a3-bc78-230eaf4ae805@nbd.name>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------YIom4upF4ujwbN83utN8hSZh"
X-ClientProxiedBy: TYCP286CA0368.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::19) To TYCPR01MB8437.jpnprd01.prod.outlook.com
 (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID:
 <52114962-f528-4121-abf2-0bbf5a56b561@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|OS3PR01MB9802:EE_
X-MS-Office365-Filtering-Correlation-Id: a65e69c7-cbf3-48d1-c7cf-08dd623058ae
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799006|12121999004|6092099012|19110799003|7092599003|8060799006|461199028|41001999003|26115399003|19111999003|14041999003|13095399003|13041999003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXZiTjVWSVZoQlBQdTVac1UrK254eGpJTlo3OGhNNlNMT1BrQmllczlmS2hC?=
 =?utf-8?B?WlQ2Uklzay9Rd3ZUbHN4Q1l0NDU4TUZxVmJCSncyanA4TVdRWnV4dk5DQm42?=
 =?utf-8?B?eHh6QXlYdzNjQS9jZEZrSWwzSDg2U2svbXRobGVjbkVzOHlKcDIzc2dqM2Fa?=
 =?utf-8?B?ckQwdnpZV044OUJZb3hZQkxIL292WGZZcHFqOGMrTUNwVVBmYjVZVlE5VDln?=
 =?utf-8?B?cmNhUDVrQVFRclZUTCtlaEpiZDJnUjZocVRiaDFWazNjRS9Dc2hOV2FPWDVB?=
 =?utf-8?B?bHNxaWdYMnhQU3l5VklUNlNabXNrR3E0K0NjdENqY3B6OC9kYWt6UlFhYk9h?=
 =?utf-8?B?UzVkTWZxS2tlUFFSZ1h0b2J6bVlJdktlTVlIV0Z4dGx3RW44WUdyajk1dWxR?=
 =?utf-8?B?UFBzRm5CdHAyN0VEQ3VRVjJNRExvQ0IzREdtZ1ZKUGlFYkFZamdzQkdEa3VG?=
 =?utf-8?B?RWNZUGYzUFpoOGczcGZCMjdBYk8xZXh0Unk1MmRIV0ZJc2xPSEpKRFc4eFZq?=
 =?utf-8?B?SmVSWTBBV3dKM2grMmlRSHk3UnRQRzBuZStqUjFId0hZRWZqQU0vbmh0M3RW?=
 =?utf-8?B?aXdENW1uaEU1cVE3cDY1UXc0N2R2ZFhBYmFzN0hMaU9Eb2tVS3ozTHhUVE1n?=
 =?utf-8?B?Y2ZrTFJlUFoxcmRpc0VCSHg5SWxzNitCMkZjWWpnYnZrOEExSWxJR1BvaFov?=
 =?utf-8?B?cDRIVGFyeFZGT245RVhOa0ZrTUNRSnI3VzJLNDJrd3BEQ1daY255TlZwQkgy?=
 =?utf-8?B?TmlLeHZMTUxGYTJVUmpMem11aXY4SW5FTllQSzZPZ1h0OHBqaVBHVXB5OTRi?=
 =?utf-8?B?dDBrdjkxcWRabThtbHRZQi9sNG9LSW5oU25uYzZiR09Va0lTbHVyaWtZdkxZ?=
 =?utf-8?B?a0JzS3pqcXNRZENITmVrK3A1QXA0cnVMY0RPN2dwLzJwTnpxbW9MR0FQamNn?=
 =?utf-8?B?SXc1blZGZUxMVVBaTG1iNFAzcmVna0VKV1dCbEJub2p1UE9xYmtYSVczQloz?=
 =?utf-8?B?WkFyenljVFlMcDkxSDBuZVRHdm5UMnVWMzk2OUpzSkNwWDdFeU41Z0VkN1F6?=
 =?utf-8?B?ODBXNUdReDl3aWRwS0pyRGQwZmFJby93eFBBZ1l2L3dmbWRieGg4d0RVUksw?=
 =?utf-8?B?ZkJtUHlidEpyR2cxZ1QrbXNpdURIWUVpNE5pMVd6Qlcrb0wyelI2S2RMRTVG?=
 =?utf-8?B?S3RsLzRaM1h4VTBzdXR4djU4UytWaWlnZ1VVUkxWQzFIMWNnOHAyL1NHSFVX?=
 =?utf-8?B?N2pldkRQMWVCdVhNTlBiT1ArNTJ6RW56YWZFS25zZ2lEcTVMTGJqcStraktz?=
 =?utf-8?B?Q2o2TmFDQS9kalYwZCsxSEdRVkxTcTJJc0hyUmVLanM0SkNQY0tqTjNLQU5V?=
 =?utf-8?B?d2FTRWRocnlFb1NlY095ZHBMcFhuQlB3TXFKbkxadFIzeWtYSlpCN0RiM2xv?=
 =?utf-8?B?YUFSQ2dtc0hiSU11Qmwvdk93bXFlYk0xNnhxVXZUWEN1dVVpUjdNTFMxOThB?=
 =?utf-8?B?czhkVXppU3lzZVZhQWN3NXVnRHdTZG9hcGJVd2pycUNTREN4bFpTNi8yc1RD?=
 =?utf-8?B?ZVFzQ21GSVoxajVuWnhRVXJzdGNkVVdnaWwwdUZPVm9PVGx0MDZMZ29DbFZh?=
 =?utf-8?B?SHFrb0hDVXFYaG5ZWDdPbGVnQ2hYalVjZEJVWmtJQXRhZSswMzdHSHJPSU14?=
 =?utf-8?B?MlJOcnp3cWRMQnl6Q2oxdVlsZCtBaEZNeWNhS25VaHMzbVV0VjF5VHdqRXN0?=
 =?utf-8?B?M1ZlSERXaTJKOENpU3h1UHNOMjhYSGtQSVpCRFV5dkZ4YVloZzBDV3pFSlhq?=
 =?utf-8?Q?WAh4gPZJO0D4gh2y8xpU/80fto8Tp6yefCYMw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2dKaVNKV3AvRTN1bmxiRDFvSlV3bDRSei9IamRhNVpmVlNDMHFVWHRObzQ5?=
 =?utf-8?B?eHlZSG9GZGI0N0FmbndTMGR0bUd4Z3lUemtpY29kVW83Nm9yNm5md0t6dldq?=
 =?utf-8?B?UCs2T0w2azVUUnJDREJFWWtpTTNLNmJmN1prTHcrV3ArKzlqTUtPVUZoT2o2?=
 =?utf-8?B?a0crendYTmdreElRRE1RbzFJR2FSVHl6SjMzY3lGMGZlMVJBMHlBRXlXZmhh?=
 =?utf-8?B?eWw3NG05K01qcDNpa0trSkN2dUdoQzRzZldVeXd2UXBKUjdBUWJ5eTVnWkg4?=
 =?utf-8?B?MjdINGFqRythSjM1RjBLakl0ajFpdVZacXJBUGFzSDFwWE03ei92VFp4cE9X?=
 =?utf-8?B?aExhL2lIRjRSZkdZQnQyQU5WUlB1Q1NXd2lGQW9ndEtQSEZPTzF1RVBsNGpH?=
 =?utf-8?B?M2ZXUGJUMU9ZaTFSS3VUT2xtRzlBRWxYZXBqazczdzlJZU1KT3JQUWo0WnVM?=
 =?utf-8?B?Sitia0xQYm1NUHZlLzBFZVF4bWlkNUVOM1E2RW44ZFp6a0c1VWhXK3NxYmFJ?=
 =?utf-8?B?djNuNGtEejVXN0hJMFpOdXIxQmN4VDVUby84MVExaEtta2t4S0lCdHVad05H?=
 =?utf-8?B?dkZTMk5mNGtMWVpIV2xjTFRZdWYwMnYrT3U4NWlMaWxYalFxRGpMa0lBeXlM?=
 =?utf-8?B?ZFA3bERJdnZuQzVrV2JkblUvL3RQSzFJZXhtVVNOeG11RFZEZjFwcUgxbzRW?=
 =?utf-8?B?UFRPSVBMbVRtQ3pwb016cmNMcnR4eHlWdlRyTWRHa0ZPOHgvYjh6dGY4TVFi?=
 =?utf-8?B?bE9MVmEyVHBJMmJKZVVIcCtEam53dXloS1loT1Z1RVNPTUpPT2xOeC9WMUlO?=
 =?utf-8?B?cDdTVUd5Y0VnclZ3R1VvdFdUUTFVT3Y3ckdlcHNHb0hxZ2VQMXFTVVQ1Qmg1?=
 =?utf-8?B?Qy82aFN4cGxMdzRES21GQ29ZRVFicnZJRm12ZmxlTlA3ZHVRdmt4OGNwVzN6?=
 =?utf-8?B?ZXIvZ201QWlCTWZhaWlRNUVqUndKZ0U1K3RpZU85UjJBcUdZY0ZyUnJxRlRD?=
 =?utf-8?B?ZW5zcFNuc0drUHZvN1NzbmszcUZmOC9uamNSaENWSFFLazNzbHVxV2VFSjRx?=
 =?utf-8?B?K3dBUC9KaHVSUTEzQ0FxSk1pY084eE5Ub1VYaGlrSlBHaFFIcnk2VDZNQUVx?=
 =?utf-8?B?WWFjVTRhb2hGYmVibDU2ZVlGcFBibFhPZngwNFlVVGpHeWM0UjRpZ2dtby9h?=
 =?utf-8?B?RUptMTZuSjZzbzNFOG9sZXp3OFJGaEFJd1ZSSjI2cERmVDl0SGFLSGE4VExR?=
 =?utf-8?B?Q29SVWVQL0c2N0N1TkRMb2hraXdrN0cwbjU3WkptbTZTWjJaVmQ2Y3JaUDVW?=
 =?utf-8?B?a2NPWlVGRzYwZGVVbUgwa2pnSUxCN0l2N21YeHJIZnlndUFKMXZaUWJERjhF?=
 =?utf-8?B?MXRqbDRCTlBjMzMxcVJhbUsvWGt4aDZIMUVnSURNWUdNNXpJbXViSEhVTkor?=
 =?utf-8?B?SmJ6S2xUUkhKdzd6dlY5R1pUNWRnMmlNK21xb010ajlSa2h5aTRGZVcvV0k3?=
 =?utf-8?B?Ni9QdTY0dG5RdVAzLy85OVJaeVAvY3JCRy90NWJ6RHhXTFhDdzdQUkNiZERt?=
 =?utf-8?B?dGhSeVZkUVdqekdNYlBMbzFad25CTjNzb2tpeVJYNTk2T1lpdXJydC9MUFlZ?=
 =?utf-8?B?eHVLQjNMMDU2TEQ0OVF4dnlnTFZGV05nWnBCYUhWSHAzKythVzhXT29Md25w?=
 =?utf-8?B?SjNmS2V2cSt4dUtkNUVxcnRyOEh3TERNSnpvb1QzZnhUSStUOXBNZkxzL0VL?=
 =?utf-8?Q?y4WA33N7hefanRHR34=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a65e69c7-cbf3-48d1-c7cf-08dd623058ae
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 13:09:54.4683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9802

--------------YIom4upF4ujwbN83utN8hSZh
Content-Type: multipart/mixed; boundary="------------mBgWSuXxSMZyAUCLWi1jnzT0";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Felix Fietkau <nbd@nbd.name>, Ping-Ke Shih <pkshih@realtek.com>,
 "lorenzo@kernel.org" <lorenzo@kernel.org>,
 "ryder.lee@mediatek.com" <ryder.lee@mediatek.com>,
 "shayne.chen@mediatek.com" <shayne.chen@mediatek.com>,
 "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Cc: wiagn233@outlook.com,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>,
 Peter Chiu <chui-hao.chiu@mediatek.com>
Message-ID: <52114962-f528-4121-abf2-0bbf5a56b561@outlook.com>
Subject: Re: [PATCH v1] mt76: mt7915: wed: find rx token by physical address
References: <TYCPR01MB8437EE1595CD4AB581C006E898C62@TYCPR01MB8437.jpnprd01.prod.outlook.com>
 <TYCPR01MB843726907C170CFE2D3EB7BE98D12@TYCPR01MB8437.jpnprd01.prod.outlook.com>
 <e144d2ffe9924d81a7b60f38cdcf516a@realtek.com>
 <1c46870f-965b-4f70-a01b-adbcd60c2876@nbd.name>
 <TYCPR01MB843770121E6576BB3807CD0A98D32@TYCPR01MB8437.jpnprd01.prod.outlook.com>
 <0ab3fb92-b529-46a3-bc78-230eaf4ae805@nbd.name>
In-Reply-To: <0ab3fb92-b529-46a3-bc78-230eaf4ae805@nbd.name>

--------------mBgWSuXxSMZyAUCLWi1jnzT0
Content-Type: multipart/mixed; boundary="------------JUJG5iKkn0pDkMUQNZ4SQiDk"

--------------JUJG5iKkn0pDkMUQNZ4SQiDk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

Q2FuIHlvdSBkbyB0aGUgdGVzdD8gSSdsbCBiZSBidXN5IGZvciBtb250aHMgc2luY2UgdG9t
b3Jyb3csIHNvIHJlYWxseSANCmRvbid0IGhhdmUgdGltZSB0byBkbyB0aGlzIHRlc3QuLi4N
Cg0KSSdsbCBzZW5kIHRoZSBwYXRjaCB2MiBmaXJzdC4NCg0KQmVzdCByZWdhcmRzLA0KU2hl
bmd5dQ0KDQrlnKggMjAyNS8zLzEzIDIwOjQ3LCBGZWxpeCBGaWV0a2F1IOWGmemBkzoNCj4g
T24gMTMuMDMuMjUgMTM6NDMsIFNoZW5neXUgUXUgd3JvdGU6DQo+PiBIaSBGZWxpeCwNCj4+
DQo+PiBJJ20gbm90IHN1cmUgYWJvdXQgdGhlIHRva2VuIElEIGluY29ycmVjdCBmcmVxdWVu
Y3ksIHRoaXMgaXMganVzdCBhIHBvcnQNCj4+IG9mIGRvd25zdHJlYW0gcGF0Y2gsIHNvcnJ5
Lg0KPiANCj4gQ2FuIHlvdSByZXByb2R1Y2UgdGhlIGlzc3VlIHRoYXQgdGhlIGRvd25zdHJl
YW0gcGF0Y2ggc3VwcG9zZWRseSBmaXhlcz8NCj4gSWYgc28sIHlvdSBjb3VsZCBhZGQgc29t
ZSBwcmludGsgdG8gY2hlY2sgaG93IGZyZXF1ZW50bHkgaXQgb2NjdXJzLg0KPiANCj4gLSBG
ZWxpeA0KDQo=
--------------JUJG5iKkn0pDkMUQNZ4SQiDk
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------JUJG5iKkn0pDkMUQNZ4SQiDk--

--------------mBgWSuXxSMZyAUCLWi1jnzT0--

--------------YIom4upF4ujwbN83utN8hSZh
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmfS2R4FAwAAAAAACgkQX75KBAfJsRnN
sQ/+LRl0ltITavHgZslRAshBk1xqw4gtzpIqFYfHMGVwPuzSWY8uBl86rmcKfCBmJAkWBXjUh1o7
xmlLgD27ngH70qx/IjuniMB8W6mZABc7xoZGMIMjaSfau8Bt7cSF7PchGdHVSce7dYoYtw7uDEYd
QIW+U0fHrbwsOd24JnHiIgJQB4WsQEIawivQbnHMvu0O7b31PaSvDiNgRb+6gxnU64wGSjOCeAn/
BZhMq8E9Q3RMSHd39bHS+1YNmjGmJXY2aoffLJ3oxWo0/mRpPVoUZU93KNg9nX0bF481tL8+u+PV
dqMyYgRA0b9XhuSeWnPta/a7q4HZkgjiXceNLREXOGt3ZJc/xCBZAuycO9FKYg7U7ZJpCbMVkrux
/Dnt9qO3OzgBvj/ZGdNDxR2bPq6L+M9TZ0BeeZ0iu3159q158PB/rl3iqua426gPxVPaGwBUnnsG
Xm8CXS4+wGP4+/HMWobcct3DbX8Ij+4oGb2yQYsWs4lp+hYw1B3Fu7xYFoD3YSYGkIU6I342jbOM
34X/3rGC1e/gA/5lS3Zs0qqvoaWsUyigrPa2yHUISW88X3JX+9xMpckabxnH65Q9/tp3xF+lyurL
UhXOpZ7FkOGojkNceCghLFk577M4gVuOj8alSg9VEPaMFofAFKAcuB2bwxeCIGO/iEkX4KR5NHjG
kIE=
=yfEu
-----END PGP SIGNATURE-----

--------------YIom4upF4ujwbN83utN8hSZh--

