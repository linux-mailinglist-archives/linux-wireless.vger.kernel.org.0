Return-Path: <linux-wireless+bounces-29336-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EDCC84C7F
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 12:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8217634D5D9
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 11:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B8E2EF646;
	Tue, 25 Nov 2025 11:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oiEoYOVs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010020.outbound.protection.outlook.com [52.103.7.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E281487F6;
	Tue, 25 Nov 2025 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764071006; cv=fail; b=mvfaWRFzQ7ZTeC99GNI1Pq81gbnco1LZSbPSNq9VSzgPWsIXeea37gFK1iO5/Pg5QjDnOCJMdHAfMTG5VDoHditV8U+eeaMjQEe6Ea+tNd7pYCPaAXgoZGxul8iQHKFHmVyXaCe/zQXz/d8Q4qaEWQcQfVWCKxSg1XO+JA2qD6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764071006; c=relaxed/simple;
	bh=XffPicec1qHnQuAOxp/swWLLjsS8kMZDRz3Bw62pnPI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CElqri6eCNXNGo7OjiCtWYjqeHpijQxDacQ4wUxVp/gK9vAQk5qDMNOY87ZJPdBYf5Gw9a2kINnz+NHUVX/S1K61G4WzfL+9OgAEG+DiIKoXZScOSJ3Jm7JrAh8CyqZpTp9PfH+0zoptKb3aTXoJsyntSjOvYSHDqOqcIsnJszA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oiEoYOVs; arc=fail smtp.client-ip=52.103.7.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgXJdG87bKIJsZjgqvEfz+1bUEH6wGz9QkrwW0R36X0xj7Axd7g98dBc5hLKAHpZ9Yxb66yfzNjUeHRN1jjEpxhu2UAcqXjjr0IPtALxNG0B5kYNK0lLsPrQL6P32R50FVcwfahoHw+ZPnjechf0jd8VjnihN6LEGHdx7VkJnIzV2SEOHiu7ZP+QiZRJ9DBjYcmOvf7AMo8P9PqR3cGciAJeoy1W+B2q9ysNmIFLzmbUlOpzgK+/Q5ezGOAh3UI+KCLHIbjZPYY6r1Tj9Io3LqiW3ZPE8drCBLINn7gcGT46vdH9JUkWXOZprEDZ/efF5CBBP5lWRj0r9dK8OxWEMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XffPicec1qHnQuAOxp/swWLLjsS8kMZDRz3Bw62pnPI=;
 b=M4j4UekJr9Pmuku3ciTw69tzPkkZC0nbz6kzXhH8bnlEGZINyXrCUIwY/9gAizGqP4OizEw2XsX86T3dxLHpA1h39WvJOaXOgrGStMMQpcBvYJ9cTPmFrEWDKcuPjd8bGf4jLTAvFxqSWqjrCeAI+pp0Zucg8uGI4gSPx+MGxN9mg86/Vmg/DtEpQtf2UU5OsxYKfANJRRPWvG2WpTSLZTVppcneLk5pQOx1lZ2OesOjTO2hrCWY5NXhIDc0vvbtwhBpGgzWU1wL7pPOO+qPFSkeGolfdNFryMkkg3quTdUbDFbA4j7joeEC/3v6yKESL93kaJHjEtO559BSMcswUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XffPicec1qHnQuAOxp/swWLLjsS8kMZDRz3Bw62pnPI=;
 b=oiEoYOVsTRM9hePxrwuBbniLQlwaUjMGJFNlkgTnxYrkGgSfJVxMse1+uWUqdOcB7CZTdm6MTDeWdomO+QjnFZpTv5hqYnarQAsbW3d47x5yceg1RIzkMSPCzji3btdwuL5ULLBCa2MGYp5aoP2aqfd7dy6eUszi51RRETkQVpG6apcKKOCOe21pTcrXevgAzB7i46NSckOUAh9WEzn0hN5RDNOhN22VCQHw1MYFea3qPkhKgPslH3F7gqzq1PuRdGN9UV/THtB1x1093lEpHk/n2qsqRcU9CkLSvhF9kfC7liet/ZdmJ5kaJOjVjjJRAUrRiTcIp1UU7dJdxyN5YA==
Received: from SA2PR10MB4460.namprd10.prod.outlook.com (2603:10b6:806:118::23)
 by BLAPR10MB5059.namprd10.prod.outlook.com (2603:10b6:208:327::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.16; Tue, 25 Nov
 2025 11:43:22 +0000
Received: from SA2PR10MB4460.namprd10.prod.outlook.com
 ([fe80::59c5:5e37:ba2b:6bd4]) by SA2PR10MB4460.namprd10.prod.outlook.com
 ([fe80::59c5:5e37:ba2b:6bd4%3]) with mapi id 15.20.9343.011; Tue, 25 Nov 2025
 11:43:22 +0000
From: Les Boys <lesboyspp43@outlook.com>
To: Ping-Ke Shih <pkshih@realtek.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH rtw-next v3] realtek/rtlwifi: remove unused two if blocks and
 put unicast  set inner if and else block
Thread-Topic: [PATCH rtw-next v3] realtek/rtlwifi: remove unused two if blocks
 and put unicast  set inner if and else block
Thread-Index: AQHcXgCzjIvM2k1HyEm9GSzOUPlRjQ==
Date: Tue, 25 Nov 2025 11:43:22 +0000
Message-ID:
 <SA2PR10MB44606485C05B0FC57402C40FA6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
References:
 <SA2PR10MB44609AAC5888DC0334D140E0A6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
 <d664a966f7754e879948039189aba8e8@realtek.com>
 <SA2PR10MB44605A853386FE1BB7174498A6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
 <SA2PR10MB4460861A8224AA99EE5ACF6BA6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
 <731806e542f245b3b3ae6d2429c499e5@realtek.com>
In-Reply-To: <731806e542f245b3b3ae6d2429c499e5@realtek.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR10MB4460:EE_|BLAPR10MB5059:EE_
x-ms-office365-filtering-correlation-id: 555565fc-2ae5-4b0a-5111-08de2c17d629
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrOdfYgTvyROVxfCNZb2OzagawbIvq1PScJT+fvPrlZUkVqJybO6XGJZBHr/CbSKupnMUXZzmfI+uxA9glpuvE2qlig4710juntKzqZ/ubaMiethScjQMGL8Z18BJW5SGCk83qP5xJNNekkpjjzlUJ1pQJOEs28E64j67+f0a3afjkZKIImccPpxTzcOrQhNVyzE8Qmh1yYdEkykncdL99LfJTJ+POz2LjXwtQitALo9wgAkKzXpcX4nFxKnApHrgr7o266WEn+ADZL0eALYU/ZFXAFo0CPTgrkjQ1mgfn6pm+tE4ag0NwOntSMmmZFLxI9npAcdAvr/LUtVCYygjdr+PYa6/10F9u5DBXsaa31qVrvAjfc5cPH+M1GfiiYdZkocty/upRkqNBBvk76ooJzOJR2wS8bIYpHGo/TPpM6sBV04w5JzOWL7k51/35oVPF1MRCiNmQ+KECbT2P0Y8MXT8EYc41RwkxXVzPe8/KXKpOuiC30+ot0mpsFvguiQjc0ndsIY0OxeCsVVjiCP73oH6ouh5mtsXtqfHXJ0WO/br7WB+3cVAhuqZwnodU/aLKXEri1sYZs7hlo4tgmUbJHVoo9WjzJgqemheEzEcafmdAPg3CLZdskjsx0nQ93RjFP+dyLHnjgHYm7UEOqZ2lQ1JV5GEm+DKc7kVDFlxWREnOaEL8dstAU1icSqyuF4bcuW1/Of6SJYN/3HidsKmHRlH94i9CWFr1dumz+iTeqGWgjXJQ0NWm98VbQuA6tOJ0U=
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|15030799006|8062599012|19110799012|51005399006|461199028|7042599007|8060799015|31061999003|40105399003|440099028|3412199025|102099032|26104999006;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?uHoasUA4mFVgn/qPgo6kuE30zGB45Z8fQw2TxoGO5aEd/ZHkR1qEzda5aA?=
 =?iso-8859-1?Q?8u07RkLLIDi2C401ZJ5oT9d1GyLRra2fD9jOmKEdmGoNLVnRY4kRUTNXyS?=
 =?iso-8859-1?Q?2eYNM/64op8mPZNKBAqf2RperwMWoqu686dGB1HzkRXCJJG9rsXD4CxBVo?=
 =?iso-8859-1?Q?Z280uDe9020u4vcaLIPxT0v2Amyz2pyzyOxfaHXDuQhsNqzquJhvqPZM7B?=
 =?iso-8859-1?Q?ORftkKul89VMgpNVl0T+Vp3gztbMZVOgic/YyM29jl/rgVGPy7E/atkZrf?=
 =?iso-8859-1?Q?RyhLsG6G1OKOg60sOVpxSbrcUHrAXl5Es4dzkISXhCNzTnIiV0RTrV6f1G?=
 =?iso-8859-1?Q?aCY5R9mmwzNOMoP9QLwasY3S91vrYHk+xeaHjgjJ6YZmnHhxQAVi1dGoA6?=
 =?iso-8859-1?Q?z8lEm+olGzz7RuapeUOxzPPYP/i+P/qs8h/lHVNt50/ENtKNbBNLWQpuvK?=
 =?iso-8859-1?Q?LmSiwUbtthuLHWlKvHo5mB6yChg+QwjNm3XkiLG8FIjIHOvPIj71rOs1FG?=
 =?iso-8859-1?Q?VkRJ7oGtYRLtGVUKxqS3wS7BqCcdGtfdLYKr4LWYclAo75TkCnqLvJuICt?=
 =?iso-8859-1?Q?PDTqCvXKVsXLWQq4Ja1Ab8nI2oUD6B76GdgtGRPqnv7LWNoyB55lI2+9ep?=
 =?iso-8859-1?Q?3BBGUJRzRa5tA9Rh/qXClmAezfzCwnOo661Z8Hey8iChLdRjIAfyQZIY98?=
 =?iso-8859-1?Q?5dd9+M3UzFJAL9feXbmYIvMixrNBMTNdguoih7XzYPC2ivoHMbnc4JGU8t?=
 =?iso-8859-1?Q?Zg+Xs7bf0o8bVz9dGEycb1pg4/htXxr555pniqgssfrxlybIiV7qhkI96H?=
 =?iso-8859-1?Q?dzLMH0iyFAz4PGKNcer/0zVwLUVMDrFyPbISRzuLO99V/6I/lsLMQXY5AN?=
 =?iso-8859-1?Q?aCAd0usPpzt1QyR6duWJ7XfFvwI5WO8mjIg50xvROH+eJAiC+9PJuklE/O?=
 =?iso-8859-1?Q?RnZ0J6nZ45dnOPRvINDjvWoDuAEeGt7des3U9UjnaycXtR8YNe5KAFLdIJ?=
 =?iso-8859-1?Q?/BCMuz3t5/gEyK2pSIABDrksO9Q78XQ6mcHhI6WvooBW/T5ylsmTlDid+v?=
 =?iso-8859-1?Q?c6oa1I5XKyHTEDadCx+zUq7VrNFsKAH5OeMJ8xWwT6Zat/T2SUbVvkwvrq?=
 =?iso-8859-1?Q?HAXKzyb4nyN4gdFtZHa3sLJoEd3XMq0G2Q0HohBiQcYiBqYVPuOLuci8VS?=
 =?iso-8859-1?Q?fcxe9cpjOlS/vYvPx94QY8VaYGS+O8ptml/pfy5LUt6RIcfGRVYKxvhF9i?=
 =?iso-8859-1?Q?liLt1o5grCTGHbkG8lQ0mPPAocfaxYfTixLJ8JFn+u9BuIJ8wxPGV1pFlq?=
 =?iso-8859-1?Q?ds/fhYW9XBRjA0rCTYGRyBR7Yw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ya/LjX1DoUjDpOso17D6lr7aqMge5nXJoE4Sgqak7n9xofz8/6RIgS6QiW?=
 =?iso-8859-1?Q?lNRtEiEvvQAIL0sakyipzVe+R7Y3HMWkwx9CNO7rbhCtt43aYgMqUrgAfm?=
 =?iso-8859-1?Q?JZPvoj9eR6i0EaB62l3j8PuLezqDxJz/F1DAyT4HeuzS2QSd6pG4TECOWN?=
 =?iso-8859-1?Q?yM6GOPaAeFPM+ppmNv/cskyfVjmaTuGzF7iyJy3Y6Cf+3RR/B06XKvcxuv?=
 =?iso-8859-1?Q?2J9DjyQ/QeHUsukSGj9UfcForm4F0wKmgUO/RNElNKR7muVehRIMUEFhwe?=
 =?iso-8859-1?Q?HQmq0MBsmqwMZqq1PC/wihLr11zlVjMk5e5j4HI8Ud9oqoTQ/1k+tTVcef?=
 =?iso-8859-1?Q?TPLyE4WTGTMp4DA49X3xxcFCaUNSIidlFQA8xizTikQ1lXpGu0Dm9zbzKU?=
 =?iso-8859-1?Q?fd16FtSq9NG2c4VYxiC/u9rLUHlF05EhFgkUiSQm3qph4hEs5VC0HwyoY3?=
 =?iso-8859-1?Q?SbJRxqSPwvCrzytT00TxtB7p6R9dPvdt1jOPqQWE1pnOP2ezx/nMUM750n?=
 =?iso-8859-1?Q?YDTA3bf5tlLVEVhMPFWU/2BaAU4B0yxtLQjSb+63dxMO1b0IhG0YuVGrlc?=
 =?iso-8859-1?Q?qcX3N/iAFrlK5ATMpy9bmv5BULryv5BK5AFba7Q+Sdw+oZp8+uDtSJYD0P?=
 =?iso-8859-1?Q?U3Epnw1DKpokEjy+s25NlajYrQBPov1XIIZg4IJnmRIeCxAzDtceroTpkX?=
 =?iso-8859-1?Q?O691Gk9gN4FXnFaPiF5t2k22B9i3ILDkrON4taJ7Ba2BqXPu+vRl3JT19E?=
 =?iso-8859-1?Q?V/M/EufKeJczQ3BAqvE8vXcxq4cVCZo8ND6JDO17tlwMTNKlx0DHsQvyP6?=
 =?iso-8859-1?Q?dkwiFZDXgvF058kwEYBFAXvOMCBqQ1tK/PYl07WCb8nVhxB7MHCHUBTeD/?=
 =?iso-8859-1?Q?A5RQqnQhZkVDUu9JD/E6rNiwG2YgTtwAcFUorSbU4QWx2rRYJ1CO7QUHQ0?=
 =?iso-8859-1?Q?er/HPBbq1Edy5rP/rBWazoBKr40PulDUujeejvpd089zsq0z5kmLd3dFUG?=
 =?iso-8859-1?Q?WysK+W7SXsf7IcwOmPYu6qtjf6YdfnYMd4qDVzH+kTWQhQaKGRthZVLmeH?=
 =?iso-8859-1?Q?i4W4YBLovYQqq1LHUdoe43mgYpIhpEEpM6QoNxEux056gkOWh/H8JQ6bKU?=
 =?iso-8859-1?Q?O2J4WgHsTtdp/uvCXLYmIwAjArrqeZX5pK42KrxV0RqsYW/KoiTB1kZ7Tr?=
 =?iso-8859-1?Q?TiefUU5OxZb8IVDvkRxYijVACFOYj03UwqCsY2Rtnsi4p5Mw/Mb7nzEEPJ?=
 =?iso-8859-1?Q?d7z2KdePFBkSO1IoNj+BdK1J7SeJRAfrFsD0YJ6r4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4460.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 555565fc-2ae5-4b0a-5111-08de2c17d629
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 11:43:22.1661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5059

---=0A=
CHANGE:=0A=
1. Ensure used the origin as base=0A=
2. Format fixings=0A=
=0A=
Signed-off-by: Les Boys <lesboyspp43@outlook.com>=0A=
---=0A=
=A0drivers/net/wireless/realtek/rtlwifi/pci.c | 9 ++++-----=0A=
=A01 file changed, 4 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wirel=
ess/realtek/rtlwifi/pci.c=0A=
index d08046926..a07de6b57 100644=0A=
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c=0A=
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c=0A=
@@ -752,14 +752,13 @@ static void _rtl_pci_rx_interrupt(struct ieee80211_hw=
 *hw)=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy(IEEE80211_SKB_RXCB(s=
kb), &rx_status,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(rx_st=
atus));=0A=
=0A=
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_broadcast_ether_addr(h=
dr->addr1)) {=0A=
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;/*TODO*/=0A=
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (is_multicast_ether=
_addr(hdr->addr1)) {=0A=
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;/*TODO*/=0A=
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_unicast_ether_addr(hdr=
->addr1)) {=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unicast =3D=
 true;=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtlpriv->st=
ats.rxbytesunicast +=3D skb->len;=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unicast =3D f=
alse;=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }=0A=
+=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtl_is_special_data(hw, skb=
, false, true);=0A=
=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ieee80211_is_data(fc)) =
{=0A=
--=0A=
2.44.0=

