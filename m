Return-Path: <linux-wireless+bounces-33083-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id a+s9MpaXsmnENwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33083-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:38:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AF8270645
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA096302BF4D
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 10:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645352E719C;
	Thu, 12 Mar 2026 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="Jg5hf9WB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013082.outbound.protection.outlook.com [52.103.35.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11E71FDA61
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773311891; cv=fail; b=mZYIo7xnjR8DfKGGDUgYRI5musgAN4fUIcLwyV8far1hTzzOu+hjfHr+xTubmPBQMORYyMWVYdTXaxYWL9KvtyzABVZTP4veJYRehwCcfC3zWlKksEKodP8+TSO6ZfKgXnmBAfIxTMXXmbiZmTnoas3h1rZ2RBpsQyC/3anJP/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773311891; c=relaxed/simple;
	bh=6C0Iz2JL6yGDoyq51l+BH+Qsis4C2I61r0PbZ3D+VQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QMJzTRJYaSqnJfTu6brz9yk54KbivSboyMXNqR4Gj9VwSHhSBg+mCUmi7hoii1boyj1NgSXDT7pnPtVJO9svmm5FleiowR9qw1ZalXNJMdQ+MnzJHyWfcFXU6Hi+aU/i69755JiFmnnQ7lzFOXthEIlFUZFwO2HBYlQ3/8BdIPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=Jg5hf9WB; arc=fail smtp.client-ip=52.103.35.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqhnvGV3TQbaam4iuoY4ecuIXiZG2cHGRXPI8mVfvRrJl73qCgjdE/BLrCahpq3ehtAd4pdF5gqb8mF+5oehbqRuhzfF75CMh1xnwwrU5z92vICQqVksXlE+F5ZijGi+6LDJFR1yuUr43e1A9hgbGlfEYpulvZ+2lrDsyZlGel7IIEon5mhl5WiUNcPJMIVFhHHX7J9namrFw1aCc5E5dlbidc6S7eowGLLksGAIfVKwnoR0d4GX9O+0sWCFcInDwUGBJi9bfjqchIeFWv8ySiarKpxsOG9gvMiblObH6ULda6E8ouaZSqEQnJv2e6OofGv8+kG6h6+eJb2HwH0fdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFMmDpmuDYJFqGziySyGcMS1H5mHSZ/0Y+2bzBJYciY=;
 b=bqBdvwTxphO3cX6Nex1bw9D/TxW+NT67hBuCqbFakeTEmwq06GsPuftfHrRJBWv4Cybl5EtF6aUmsgIDjm7lq7b0dM1Co+UfrEfWHpvT5GuMGz7JSmiZgexSIQvZv/2bB9qk4WDRyzhDj1LbuTsH0VEHhF1Y03Q7f8o4jj+XEMJFnsxL7XbRRI2H4pw1HOAH2OXLFSOJDBeobDXGCtXusYgg7tYLDFxeaqvxdb4W+zt3wQ37V4X4bjjiPf+S0VU/i1xvlRNDB0xiS/VCn3wwJJCVCzhdIaoN6qgsB35i/OUKW++PoJu0T10tYJcDWu7v6zS905rmEEJvE5qz9q58CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFMmDpmuDYJFqGziySyGcMS1H5mHSZ/0Y+2bzBJYciY=;
 b=Jg5hf9WBkyssr9daUN4KHSRyRtgAI6yUnrdJIZF96OCsDN1JpJZh4TyzH/fIxvp2klUTZ9QnKOcJkE0Yc/suFzSGMF27u6ug0q2XRXj8tVMkZc4wkdtbntMfMXQjI79Ge67bIJW2thk8sybP8FmAB+jrWS/COFrO5X5gU0OAx//uDxQKkwdkCtSM0uQhKm7i5IXk3J3eGfhTUXuBqVRZGjTQqrgfrx9RUVpbUgqwW/RK14dtqMNEPd7/q7yzCiYos9jbpoOsJEFuIqnqWxCuKMnGoMViwquHck/LDbYCoiTExtq9i3+FnnFKwFtSlBtaVvfb8tOdAsWI8MH3NdAlqQ==
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851) by DB9P251MB0259.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:2c0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 10:38:07 +0000
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::1ed:268:bd65:b36c]) by AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::1ed:268:bd65:b36c%8]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 10:38:07 +0000
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
	Masi Osmani <mas-i@hotmail.de>,
	ath9k-devel@qca.qualcomm.com
Subject: [PATCH 00/10] carl9170: 802.11n compliance and driver improvements
Date: Thu, 12 Mar 2026 11:37:55 +0100
Message-ID:
 <AM7PPF5613FA0B6D188CBDBAFC0CE13247A9444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0353.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::16) To AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851)
X-Microsoft-Original-Message-ID: <cover.1773277728.git.mas-i@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PPF5613FA0B6:EE_|DB9P251MB0259:EE_
X-MS-Office365-Filtering-Correlation-Id: b951f565-8b78-4a28-40c2-08de802372c0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|23021999003|15080799012|19110799012|5072599009|12121999013|461199028|39105399006|440099028|3412199025|12091999003|3430499032|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QfrWP5ZL5UifmgZ3Zfyyz/ot3w9Z9uTtfL72LoyO1ir9sxq4adGZ+r90iYyC?=
 =?us-ascii?Q?Ll6i8zb0zsR4CeivqCt1CH2GoUJf5mGcIGSkF4m2eNQtf4IEOJgwz/vjqEZs?=
 =?us-ascii?Q?Jlz+LNcZxcnDms4syH12tLggrwfoDT8DXG+n/wrGBxjTL4fwbXe8kUZ689Sb?=
 =?us-ascii?Q?t77vLqtOWRC8qHkMXan5kPOmc0sR7A9v1+3HXef7jt62beVhhlnLQpbGnsHS?=
 =?us-ascii?Q?nZdT+Fe6BFEWR6A+CL17e7ykKuqRLY8BX0vjKVYU1mM1BOumf9HGqvD/Y9rx?=
 =?us-ascii?Q?xBhx28AqTccAkWTgNYMKIynMw060lF9CD4wEu8EP/9gd3WcIvZmH2Xy9b3lx?=
 =?us-ascii?Q?Gb8ukaTijFuLP0fgsMsvO1AulHpRiTSw4rvFqvn7wGDbgTl3QFOIlMt2YTmT?=
 =?us-ascii?Q?DYR91+wiztiUOeRtidtZYRxTaSB8cVZxGRSNcn1XYzR5hGhEP6gnTVgxWPVo?=
 =?us-ascii?Q?I6+J7r9lo51B9d15VhvdW68V2a3CShuZdIS5JksYW3eRGP7poZ87PwypGKqv?=
 =?us-ascii?Q?p2kQrIa+NMizK9s0onWyUpw2F6m6zLYlXgU0ifSWdkGFjHmdImTvUyH/HtQk?=
 =?us-ascii?Q?Ge+8TiGkvIRmcof138SgyC/57tb95PuRXukkS+O323x/Cp7QGmjqHIt4MqCr?=
 =?us-ascii?Q?nkduvVB/F04edtvdLXHC2yqgcUC7Zm7qoheoDyHB6WJ28uUOiuNpye883cV0?=
 =?us-ascii?Q?uWS4z1en87RKHgtSTyqEYvqM1NEwvq6BAxLla0+exLmoCaq0FpC8OT887VLI?=
 =?us-ascii?Q?qzPS9/yoCRHGotwTYV8IWX9EvpxFXhdD3srK3Pu6CKmRs/0hexWKk+xFuKd0?=
 =?us-ascii?Q?9owuAgDCyqa0UY3BXYYgJ/y6VVPI/jkqOtiIUgz1czBcibiex/6jOsxs4jCo?=
 =?us-ascii?Q?Zq0OiWJ5RHv+710/qFRutIVRJq2UKcI5dkXuomsLXbWDsI+AxdW80n1zQ0z+?=
 =?us-ascii?Q?RRAR3fIyJL0WEA2HpotbLIJ7csfs/u50FBDZDuIThLk5xzhQF0OULEzWEY5y?=
 =?us-ascii?Q?7Vfw?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TsRia2Ly+1blorKQPiUB8VuE/SOSVPwXra7i48rUTwe07OPMucm3N4zdwAy6?=
 =?us-ascii?Q?hr77YDPv2HUIO9JldI7T1JCnOLub1bxPbFlfNjZRITjBT/i4aCdU37itVPeT?=
 =?us-ascii?Q?SXgYmYNx8BjD8y5nyWlN8UbI5pSfqf+d1szK0jRmh16beCtLaNs6MdpXZVOO?=
 =?us-ascii?Q?xb7resHwmALCvKC7DjN/fG2h2RBkqx2KRcr3TqirsC7Pnv2pm8KUTWF/TgsF?=
 =?us-ascii?Q?K5EALHfRF/pbugxS8N0XBMERC/kwwLGvuR8FMvfMU4HbpuZOMA71yIoCVH90?=
 =?us-ascii?Q?7luCScV72uiXnmi2oOMCIrceKSYSPUgMoAX1RSOaoFMvYpQJ389pA9WJAKN0?=
 =?us-ascii?Q?eAOv/GpWOFe/akzJc26RAtZnDSfGrdyVvpgyi8HvgNdidkDcWB7j6tRGsf07?=
 =?us-ascii?Q?9b5/3DSYFb3PkL0iYwIJB7F9hxq9CMDP2TOy0VafGv8e4nYGPyV/STRPI5tM?=
 =?us-ascii?Q?sAyZW68Dovei+CN5QImG7aLJ2NA3K9yedXPYZj2CQBOkHVdCva+u8H81d056?=
 =?us-ascii?Q?AodKOwgTh2tqeuCFDnupNk/qqwl4eMOLyTgkjg9MgIB0nNEwdRIqIMK8sA48?=
 =?us-ascii?Q?D8SQ8l6nETD+72a9KBPmkxuyQ8y+fb7NHv9VSBlBXEwAP+i5qOXqAeuyo2oq?=
 =?us-ascii?Q?F4wazNGiWfE7ev9Qucc+uECIDLwE7P93zrOnXChHZkVhUHAiO7kzsVww4SLO?=
 =?us-ascii?Q?kdXX/rJW1oaXGsIgW9Iv4wL2ajgYRnXSfA5V18DYdEQan9eVZbRDrjn36XOO?=
 =?us-ascii?Q?Rk0MPsJLGI9wKTKpuRw1vx/qbJUdi5QedDlUnq8Ap8LENq78ZPKD4dzQtYbD?=
 =?us-ascii?Q?DNMmx99YnU60ImupHKsgZAOsd5Y7W8bzJ+ATgyT5t0wgxopiOmc2qIr9b7YC?=
 =?us-ascii?Q?QAMFPvVvBqvFxX1B6IkM0IaaG4OgxoAVTWACeFKKdfP2GWcasSA8FSMD6jep?=
 =?us-ascii?Q?m2Ehg/Kfu2fx+X8MJL3qExmAYwi47do2CCnKjV2O3/EtdFU5ZfWu8UCenb1m?=
 =?us-ascii?Q?F33bAdrxAo691O+6Lnp5XGXWRq9yzGIcEMx1H9EljPJur5xopbJCwXOKND8x?=
 =?us-ascii?Q?gYYd5iTXvAiykRbwtVGKgTO5jHt7anE/po2tZNkXvV5sUh6oVblZ4pVkpklQ?=
 =?us-ascii?Q?0Ae58GYKHZJlnV7AlNG81SolmKEcHhcPiTeLLNTzH6do4Aw2ynVHDHPp5Odk?=
 =?us-ascii?Q?Jpwq3BFjgbfm8yilbo9Dsh/t8qU7xn4GbGPhVBW1pFJQIGelQcTpV2PlIBs7?=
 =?us-ascii?Q?12k3DbOFskW2dbVa/xkJBe9z7/CZEYucsGueYTWTZt6niXAWL71MY0jizeI3?=
 =?us-ascii?Q?IZ2ZHfih8hU7KyV1kmSC0dgDaMT4LAq4EKkONxXpM6HGwEg53YZVHixVTgvm?=
 =?us-ascii?Q?IaLDHpmiSDCuN4vDMcQD6V0MQpcg?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b951f565-8b78-4a28-40c2-08de802372c0
X-MS-Exchange-CrossTenant-AuthSource: AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 10:38:07.3116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P251MB0259
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33083-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,hotmail.de,qca.qualcomm.com];
	DKIM_TRACE(0.00)[HOTMAIL.DE:+];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mas-i@hotmail.de,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[hotmail.de];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[HOTMAIL.DE:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 66AF8270645
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The carl9170 driver for Atheros AR9170-based USB WiFi adapters has been
effectively unmaintained since 2016.  While the hardware shipped as
Draft-N certified, several 802.11n capabilities were never advertised
to mac80211, diagnostic counters were left as TODO stubs, and some
hardware features were never wired up.

This series addresses these gaps in 10 independent patches, ordered
from simple HT capability flags to more involved PHY programming:

Patches 1-3: HT capability corrections
  - Enable SGI_20 (was only SGI_40)
  - Advertise RX STBC (1 spatial stream)
  - Document the SMPS handler (replacing bare TODO)

Patches 4-5: Diagnostic counters
  - Wire up the RX dropped frame counter
  - Track PHY errors via debugfs

Patch 6: TX power calibration
  - Replace hardcoded 18 dBm with per-channel EEPROM values

Patch 7: Recovery hardening
  - Add exponential backoff to prevent restart storms

Patch 8: Antenna diversity
  - Enable fast antenna diversity for 2-chain devices

Patch 9: DFS radar detection
  - Program radar registers, call ieee80211_radar_detected()

Patch 10: Runtime IQ calibration
  - Periodic I/Q recalibration via existing stat_work timer

All patches are individually compile-tested and have been verified
on real hardware (AVM Fritz!WLAN USB Stick N, AR9001U) running
kernel 6.18.12.  Each patch applies and compiles independently on
top of the previous ones.

The ath9k PCI driver for the same chipset family serves as the
primary reference for register programming and capability flags.

Masi Osmani (10):
  carl9170: mac80211: enable Short Guard Interval for 20 MHz
  carl9170: mac80211: advertise RX STBC capability
  carl9170: mac80211: document spatial multiplexing power save handler
  carl9170: rx: wire up dropped frame counter
  carl9170: rx: track PHY errors via debugfs
  carl9170: phy: populate per-channel TX power from EEPROM
  carl9170: main: add exponential restart backoff
  carl9170: phy: enable antenna diversity for 2-chain devices
  carl9170: fw: enable DFS radar detection
  carl9170: phy: add periodic runtime IQ calibration

 drivers/net/wireless/ath/carl9170/carl9170.h |   5 +
 drivers/net/wireless/ath/carl9170/debug.c    |   2 +
 drivers/net/wireless/ath/carl9170/fw.c       |   3 +
 drivers/net/wireless/ath/carl9170/main.c     |  45 ++++-
 drivers/net/wireless/ath/carl9170/phy.c      | 194 +++++++++++++++++++
 drivers/net/wireless/ath/carl9170/rx.c       |  23 ++-
 6 files changed, 261 insertions(+), 11 deletions(-)

--
2.51.0


