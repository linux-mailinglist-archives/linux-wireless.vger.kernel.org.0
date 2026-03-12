Return-Path: <linux-wireless+bounces-34247-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LxsRMsQwzGmwRAYAu9opvQ
	(envelope-from <linux-wireless+bounces-34247-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 22:38:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EA93712F8
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 22:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C909306DFE8
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 20:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3973BC67C;
	Tue, 31 Mar 2026 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="SroeZ9tn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazolkn19011029.outbound.protection.outlook.com [52.103.34.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEE224728F
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 20:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.34.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774989504; cv=fail; b=OCgLQrVw6NCHXWFCKBdiOc7CXA6R7YaptZh9j5KDe3Vi4v8LFgT3/9+/Hk+5NCWzJuaDD3WfnT1Qm8RRhYMbZ//nd3j4X2H1STPazyZXU3qHX5DNbjzNbqlSGHnYpYqBsAPhOMkco5zwOEEsgdgCTgOSVy6VbVaHzNrdC9G+qjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774989504; c=relaxed/simple;
	bh=RV+VmCLTPP/2Oskde8Fzwqjv5wNMkXVLYTVUsmCwd5Q=;
	h=Message-ID:From:Date:Subject:To:Cc:Content-Type:MIME-Version; b=sntL0tEB7zavMEy7bo0cdT0wHPNfQ5Z4dvdAWpmzLYAMG1KK4H/fYIt87Jb9PhC8eaEr1KmbVDDsFly8GlUNfSckK5U6IcXtXPX1gzLfFcxPSqTU0s5hoPLklAriLtbOdEjr+1HiuvBBOtMgvC7J9btGgsRHmofxgmpxT5uXUkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=SroeZ9tn; arc=fail smtp.client-ip=52.103.34.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SC6D4RjD5dopP7sAwrSuN3DJKSZL59EI0P7xFolCdHNeE4mUjprJGLn9xL5yh35UDfnW4i1Fc8Fizpb2dQiqdECaNSP12Q6B5mKxx1Zrbb89Cg9sI/LnpO2+UPHPSrjCajCJ/B1+BjAAs4FSEztYcFm3/UWdkfCRIY9sAtbd2y8HgylVuoOCKeCn1uNdwc/Su/IjjddWuh7COU3E9I4+hQQ/YOwg8q4xRkQPb/MFgzY3aLON34n6jrRqCNf7eebWJEQ4rBalkFPH1dIDMPdbPkl2iyhN902ozU1xdPCC/Kh/HSbzyuQPZFfyXKs06E5CskXanwOZSm3Eu6eTlC07JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5Sjdm7rs5OKewmsc3Mmal7p9DJ14K9pe/ErDinogUM=;
 b=koD82S4wHumlzVoOkc0GsZkU3265Qt7AkR9fZOBueP+4lvrCj69wAyatnBzN8ne4peVM0gi4UIJps8y5K1VKmUjwEP1xDppPpHaOY1lZnAoGj69a8ifmVw1AbxBJ/HJouuUtlmnwdH40ld1IA0n8ywRH1aKdbjwq5uxnWf2Ib6uhxj1KayXH8QCHELSV8O0ZoWu/+m8ysp8Kc2TxkX/zshX1iKM9QfsJm+8cyMPNT/q3iK6koTcPdHzaM/WSxqSSCM8zxCqq6o5duUyrjdAcNrqls7RRoRyoPIxXN/9UZ9zmnblKixDqMAx2t8rQoGwHh0LnLo25Ojwtb+fEZceMtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5Sjdm7rs5OKewmsc3Mmal7p9DJ14K9pe/ErDinogUM=;
 b=SroeZ9tng+xzirOMtErMLXLsMviLr69zWRmrhkm1TBEknbCGd+E3AX97UWLaPiTG7sOAb0FsRxkuE+BuDycyE8tal6dBF5GDFlQ1BQEvI4x7JEd+Hn9RlzEEVlPcscKtIzUT9lEjaKaBQLLMW4d49FJLuD/Nqice0XVrDlxf4JDPU8MurcFvw3Ebz8y+4RctcyryKz9gnm1mafoMk88CHRc7t5IHdh95CbyUrc4kaxAt9bgeLum/CtzfIiALMd0iXBl4rmwasp3xx0iu94k2P78mtyW3F3wZ894c8Vjm7hj65NQaSPUFaGPMPRcCGgJIuzrCYJllYVIBe1vwFbv28w==
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:19b::9)
 by MM0P280MB0851.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 20:38:20 +0000
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f]) by GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f%4]) with mapi id 15.20.9723.018; Tue, 31 Mar 2026
 20:38:20 +0000
Message-ID:
 <GVYP280MB151865A48A1D8657DE7934AE9453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
From: Masi Osmani <mas-i@hotmail.de>
Date: Thu, 12 Mar 2026 02:03:43 +0100
Subject: [PATCH v2 02/16] carl9170: mac80211: advertise RX STBC capability
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
    ath9k-devel@qca.qualcomm.com
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0076.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::9) To GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:19b::9)
X-Microsoft-Original-Message-ID: <57376c8ef1794385e8b247ed8ea60b86@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1518:EE_|MM0P280MB0851:EE_
X-MS-Office365-Filtering-Correlation-Id: 1651417d-2d94-4f60-75a5-08de8f6571fd
X-MS-Exchange-SLBlob-MailProps:
	30ekHghIwFrYYoNnnwxejuezs5MQ3rParuaOGIRmjRATCkxCmgnBg5UCWE1muq99Ng4WCUFgPOunkn8D196/wk7mQm6zK2RkFCaCQ8bLPDC8UtDRs46HDb6j22NQQqEwzjP21sD77mTiuOJw5okm2IEDOGVedhZ9rWQyHbpTlqTP/jDJDZ1GKWDIh8mO28UJLMA1aoSPLDlQbiDP/j5iVNi2l7rdD4jODaZi84H/Sw077PGV11y/VNrGyFurKAgVcImFjGWlgwCvN7O2+Z4vCZ+lvi2uk5wBn2++6icpyYloIl24nH+23983bWA4QhBwBnxmTJNIfDr+C0a6uHXTqCsWDD0nOTWQNzH8ld9JuyCaaiQgPVP/XirpJnYBxcDdtb+owWxs8e8Qp+zc1R9QRb4FW9lG/GB/XLapBuYQB4qiYjN4eUv8ZpcERKTYy8VfLBHHqGCvgZbzy/crtb5nQhaSpwYWAfPJDlMQeAiiQaMER9+Uf7Lh68pkOrgOX4SX9x6Me81TA0u6Nq7h9kbSclbvr11gjzgwJl9XFUN9nc495hA2oHnIazWZheAiQBJOaH7gEEa/xOuetDv1whYrKoUtqzbHwzn4i6Z8Kq77hwriIOf7G++2WjJkgSN2k6R6NHR+Gjq2LuFURDxzjRqmskoCakkmN8XMhAVg7Pa7KayKGxyoZIt38h0bmbGeke20u/8CW6pifNjatYXrT20lFo9Itqqk0TxZypUgOYwukgvjkKpldniujbTYNY+fbLDV
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|8060799015|23021999003|5072599009|5062599005|19110799012|15080799012|461199028|26121999003|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8wiPSUCQgy2x0mQslliJgrhsDHK3d9uxjqdWyPU5HxhCJl526TGd6VVGLJnT?=
 =?us-ascii?Q?03vHqPXMt6tH6ero8IsI/KSKauld4e9YYlfL5O2sc66fE4pFR39zL92TtDCl?=
 =?us-ascii?Q?7FBcTa9LrBzbAYwr3Mku1sFifC5RHnze5iBHsR2Awp+QB/e3PfdVkWWdpjrX?=
 =?us-ascii?Q?fL7gpNGyopSPVLfnYGb5BtJn8O08EA3qJAQAKKDShwJTHTklvxxYjBB6CX1z?=
 =?us-ascii?Q?abi62KeK6brFpAoJow7uwb1Jka6vRBWTmQplEQvo/774llr6txvbkGQeGTuz?=
 =?us-ascii?Q?xsogVKD1uV247abXyh9fRtyU8bTTo1kKZDSGyfNixkQ+ZUeY/FyvU+6Q2Q3F?=
 =?us-ascii?Q?TxcblXFQWpSwCgN6yWyRq2iPpXwIHDDeBJ3901IXRkbXPUUhJXHYEij/9/r5?=
 =?us-ascii?Q?pz5Sbx+y8jrymRiegAF4MMFUl3i3cpMyv36ap8Nvokufxf3YstlLth1bTO7j?=
 =?us-ascii?Q?01EZINdOFB7VnvfiW9cxopBazuh0sbVKJSbPk2x2/WAqMMX3T4gsALKmnAI7?=
 =?us-ascii?Q?rhbz0dxKnVA9OPGSApSBxgtA47nA6sbsncLRJ1bDpyAkrsEyaBRT9dh9zo5k?=
 =?us-ascii?Q?dSTRpXDs8pjVI0uvN1Fso46kmwrJP+MUOpVD7HCkptmwVm1ZyopUmPqaowGb?=
 =?us-ascii?Q?HUSCm1GMyTxwfR5Vw1tCV306qGTK0elt8YdN33K9C57KALIhjqSIuYzkuUgO?=
 =?us-ascii?Q?w2VY3sPuksObj7DO/5wVYQnzGyB5sFaCqDbkkr/oRBi6oZVC6OxdESboJWG2?=
 =?us-ascii?Q?BV/Ykm7VrFbKsLzoSwkOXX4BqKvNhxXR4Lt3o07Wq1AfrBMx9gCxYCnmY4wn?=
 =?us-ascii?Q?AwmWxamsvX7Ig4Ij+hzCUZPtabZ1durqxuOZXSajZ0/ZG7hxzhTxRhvJEili?=
 =?us-ascii?Q?aqGNjTmnbU2zD86TT0SGRDUNHup7VUZOVpgcNVMVcvwouCkHgFV3SKVmuHC0?=
 =?us-ascii?Q?zDrMBQVJvDYJfhre9P6fqw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2n6eSxGiMPiUqwa///mhqJU57AmhJINnfom+LUQXhH1XXw9Kge9D9+22muj8?=
 =?us-ascii?Q?OBammvaIFZRttmwc3Z2+P87NfTWo1EhKN8l8/qbyjj2qgcV2tnBZsGYt4WVX?=
 =?us-ascii?Q?3raYZwa8SDGrkvKprbmQYuMgnyl+FXWrcR8k6kLFQE0RlIbrJOoXcsE3sNTl?=
 =?us-ascii?Q?aYNPjY1QZO4Jk5+/1DelXIAmSwwxgJ9tF+gJmmN9yVjzentSOpMxwkGnsS6W?=
 =?us-ascii?Q?EtsOqKon0/f1n/s52MPP+hTCADUN+AiApeqmxTOmAgC9Qj2T7YnQP6LeSnrH?=
 =?us-ascii?Q?iuqrG42FJgpUAdJ7iSw/9ptANchNBxu0Mukna4E6hHqGkY0sRh57hLVxphb1?=
 =?us-ascii?Q?etF0sE/heqjIfMSxV4UPl8xdB4pGIaH6k3hO4vnN4i8IwVlpung8VKHoKgFs?=
 =?us-ascii?Q?3bZ9nUO7XafMRLbB+qKGJ88RorvK4jJC+fkSwc036F27ly9FuF4Pd+94Rmvz?=
 =?us-ascii?Q?Mpft0/aBvJLftM2K4GLnz795qGaBjOcL4k7LpoCHTBAPT6I0Pu63seRUIojD?=
 =?us-ascii?Q?bvWnopIsk0cYLiW0lGBEU9+kX9aQSHTxwjB/4dU/WVzMoUtHmtGN8Uv1aKaQ?=
 =?us-ascii?Q?WPvWQG6wzxp+3daPNFFMfK0ej++KslPW2UQJApNc/JdeGe9u9pKKpzVAkwSM?=
 =?us-ascii?Q?MlEDVwmoeqUTxhXaCzxL++McYc6CxaoyGeZXaSPyZ/4Tw6uqOQaol092VV0x?=
 =?us-ascii?Q?pu6Nvl3oLZhSQvLvETexxFq+VxJ3LkYrY7gmeAG7qlfpaeRNQJ9JP6djoIN8?=
 =?us-ascii?Q?A2ugqV5cM+G99Bf7ZEFxGqmGvYzPzVgTAfAtZjBPiyLGjgolIxhMgeDneLOu?=
 =?us-ascii?Q?AnryJuLI8QTZLf6vcqyh3Ec1+6m/d1pytSB5IX08CUSkVcNLk8SwsI+iI350?=
 =?us-ascii?Q?PKqh5CVAweVjbGhyoSSfnLLGuOb9xfwFTVfahe9RpGCjaxFYfz9YiyKnHI9A?=
 =?us-ascii?Q?4F8bDAgGqCwOlNn5PJLw0jpSVqQdASUKiI+Dhkq2DjK1Z+1ZtAh4Od+vPWPQ?=
 =?us-ascii?Q?3Af7fAuJmaKi92rEOaV7l+HltUPlQtVY85cnXUmDUd5n/d7cu+4jyTN7o3qp?=
 =?us-ascii?Q?yetiAC7rIyg57HOkILPPylHJGsSObUbkwlOYcMGErlLNkWjXzUDOmk0tTSB8?=
 =?us-ascii?Q?h554lD7gMjqX3EyZQa7PkkK9W3qBsZ1RKROH9I8ozgXQXkaGJeohHeq5WlaZ?=
 =?us-ascii?Q?MiiC/TzOASQh++tiDcHVzwST17C+QU4gwNIV+cfDXTl9S9c6VEkzqfQPncW1?=
 =?us-ascii?Q?daYZ2aHGgFIDC0wvBVNABWbBkCfI646RTUfUlY4SsA3VUCrHsMGoZgVpv444?=
 =?us-ascii?Q?3Ec4ppiYSCoNLs7iDy5s3sdfNCie/J4HZREOHZkC/cXJzhHI6eJorqSvSkvF?=
 =?us-ascii?Q?CClfdSXAR5HnQx7ypygO/LiefFkX?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-10872.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1651417d-2d94-4f60-75a5-08de8f6571fd
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 20:38:20.1682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MM0P280MB0851
X-Spamd-Result: default: False [1.34 / 15.00];
	DATE_IN_PAST(1.00)[475];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34247-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[hotmail.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mas-i@hotmail.de,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[HOTMAIL.DE:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hotmail.de:email,GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM:mid,HOTMAIL.DE:dkim]
X-Rspamd-Queue-Id: 39EA93712F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The AR9170 has two physical RX chains (rx_mask == 3 in EEPROM), which
is sufficient for STBC 1-stream reception per the 802.11n specification.
The capability was not advertised, causing peers to never use STBC when
transmitting to us.

Enabling RX STBC improves receive diversity in multipath environments.
The capability has been verified working on Fritz!WLAN N (AR9170) hardware
over several weeks of operation without errors or instability.

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
Changes in v2:
  - Remove erroneous reference to ath9k's AR_SREV_9280_20_OR_LATER in
    commit message.  The 2-antenna capability is confirmed by EEPROM
    rx_mask == 3 on tested hardware (Fritz!WLAN N), not by a silicon
    revision gate.

 drivers/net/wireless/ath/carl9170/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index af632418f..8a77345fd 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -155,7 +155,8 @@ static struct ieee80211_channel carl9170_5ghz_chantable[] = {
 			  IEEE80211_HT_CAP_SUP_WIDTH_20_40 |		\
 			  IEEE80211_HT_CAP_SGI_40 |			\
 			  IEEE80211_HT_CAP_DSSSCCK40 |			\
-			  IEEE80211_HT_CAP_SM_PS,			\
+			  IEEE80211_HT_CAP_SM_PS |			\
+			  (1 << IEEE80211_HT_CAP_RX_STBC_SHIFT),	\
 	.ampdu_factor	= IEEE80211_HT_MAX_AMPDU_64K,			\
 	.ampdu_density	= IEEE80211_HT_MPDU_DENSITY_8,			\
 	.mcs		= {						\
--
2.53.0


