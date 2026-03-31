Return-Path: <linux-wireless+bounces-34229-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gN/4KYsZzGnHPgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34229-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 20:59:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6AF3704BD
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 20:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E1F730488D7
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 18:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410152FD7D3;
	Tue, 31 Mar 2026 18:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="qQzgS8/5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVZP280CU018.outbound.protection.outlook.com (mail-swedencentralazolkn19012050.outbound.protection.outlook.com [52.103.35.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74103A1A58
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 18:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774983519; cv=fail; b=SWdX7hvc9CXBo0hENjakMWKQEGyOP5dqH7FUkfd3RSYDZ5msvGTfc3+mwAXrh1YMkSR8ewCukk/Hedr0jERemeTETGzWqA1ys/i+O7RMPdF6rXp4xRYIUfLTpCIhjzRFTdjn7bXVKlfVq8DDZi86QJy6b0ysBEIxgett0Wx5UII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774983519; c=relaxed/simple;
	bh=VetO7dkqHS9EkHhpx/kb5LwZKQKluM49lTZmjJo85f0=;
	h=Date:Message-ID:From:To:CC:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PJg0MpUBmjHbaZzQkgSf+IXDFaq8C5jLGvhsY6hSCZW48KIojCZi51BDenGowY/qDC5SHmDWR1wRowIuubi33VR73hWcMeFZX2q2GIe+W9Ozk14A0+vXTXL7exvjR+xGDQRc4uXnNbMDNmiMuu5DofC8qD8SWebpk0g5/362XMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=qQzgS8/5; arc=fail smtp.client-ip=52.103.35.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkVWvhLGX3oPRbk9xnMJUsfRoinSfbNfYBw697VDfi0Bfukk33s5411cdFgIlRVeA+CMGTpYsTY/9F1v6pBcFJo0Y9iAZ8uCoTZRpVQEYEMGFyrzk6EnX/NcnUVmIkoX9J0ZrVPR/jAF9R+CIqFormwJDzH7VAf+/A89q8dAJ911C/I/uTDIuhZMm0HORHHajRCimUWJx8u5fLVsEa1KPn23c1CRYWJmecYH0zy749X6Zffla5A6qMpvqCsU+jjhtNopsDteq/NA5D5HKrXsa28G8W1HJMzS1Qnw0YPuZoyhlVqApKYU+Gzmv6L6aiHfm2Fkib8MvJERXcUMaRi5GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bk9Z52wFlyvjWstMfVDoBhoOMoGz4Ytu1RCEfSo1jnA=;
 b=kbS4PK/8IqpG6MVNCo49RCh9naqJN/7QwhdEO8zkI8rycaEPT54LfdI0A587kPkl81OkRWSynq6KftiBc/kKbeWAOIesBiDCQTGp23z4Pcw9qB2blrpCXQrMbeLEn8YrToXbiaY9x0ga3CsADt+dVkBl0bZ0mTPBfrnUy5EILwhW9H46AIQjpK2YnPPx7h3CoJeEFebTxqPopAKqbswi90GfAORtXH/Zs+8h0FF5oOqM6y3dG86zWPQPS/jPgBIId4rZqOWAFbA0Q8/usom6GE9TkHqUYY3Bfae3otqieyDkCXbjHfD6hU+Ct6aE9RnpEKWmhL3BpobpllbRX/XZ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk9Z52wFlyvjWstMfVDoBhoOMoGz4Ytu1RCEfSo1jnA=;
 b=qQzgS8/5VUOEVjhCbekawJoYKYsWAaOinKSkw9n7sPJxc2DXaZl21LUtT2evnS+47+h+4M4yOUX2oGKD5ZwaRjVZPQOhhxNmABwhCbKNXz6Yk0A4psnmCWsRsfmEgjI2a/Qqnqq+lMhMIbTy5atNh6kWikI76V/qzK8Nk8v94Pd/8Pf1yFQJvqOn8FJNKp9hp+ruN7gYG4w8Lk2S+X/e2XXGgwSdmladatGNXmdAe5+2LETE0WgqxJdidbkbkoNulvQg9DpBCVTjpVm6zsrwVvdN2Ih1xQ866RZKoqWqO0xmwGU4+QynLFNXwKX4isR0vr2UUhja26kmwTPi2Toxdw==
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:19b::9)
 by MM0P280MB0978.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 18:58:34 +0000
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f]) by GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f%4]) with mapi id 15.20.9723.018; Tue, 31 Mar 2026
 18:58:34 +0000
Date: Tue, 31 Mar 2026 20:58:32 +0200
Message-ID:
 <GVYP280MB1518B5DFE59FFFE343F3D5709453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@gmail.com>
CC: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Subject: Re: [PATCH 12/12] carl9170: rx: handle zeroed PLCP CCK rate as corrupted
In-Reply-To: <cbeeac30-ff8e-4db0-bba9-30942001f557@gmail.com>
References: <AM7PPF5613FA0B686F41D14D2742825BE219443A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM> <cbeeac30-ff8e-4db0-bba9-30942001f557@gmail.com>
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::17) To GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:19b::9)
X-Microsoft-Original-Message-ID: <8d480cf9ca6e4e6feef2d24c4810d02d@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1518:EE_|MM0P280MB0978:EE_
X-MS-Office365-Filtering-Correlation-Id: 852230ac-eb07-4d51-4176-08de8f578213
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|19110799012|461199028|8060799015|15080799012|51005399006|5072599009|440099028|3412199025|26121999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	9gxDvRIjnhmNb6FR6UD5ezibboKUyoJACNzvLp2aI856rQqR3an6AUxmsKZAN1eBPssVDdm4gsOPneqxI7nZHQHxr9CXEo8yrhljlLutSFvu5pDxRWMdyVQOQQ5evzttxy+iomc9YVEqpmyFtGQSa3rFlGMX3CqJSW2jpTbWmd9QxiJmk627fuFOMHNnB9slpYsy0r6mBDyn+cp+4tH9BZ07Wz3mqba7vWp3GbcR9+rYSUnO9gq9V+Z6SbEKo4kfWpI8UVHIMDm4Ss7RIq3ckk/S891kY/G7yYn17LfylKQj5i28MDHrtxKf9ALKGHxfdSWnolBsqzN5go/J/rwk5lfcE3dz1deB0TI/7IjoAMlrr4chDtijD+YoR4lqIlBQZwF1gltfbgwYxHa0ulptEP5LcQpYAjJ7LcjKtv1gGweFMYbOpIZjxEN0HIxFOp9M50hjWC/I7RxWUXQGN7HVF28Koh0Dlbobfh9ul4h59X7jA69kyaLc9oilzUw87lioeUDaSP25ae/vV2vE8UVXOorzz5P1uAHOiozz3J7GryaWRw2p5DKzuqm/wIxIrMLczVLfzaSmw52QdaeiU1Xiq5Ax+z/aVZ8T3IrMqQ3bgxPPNn2krCr1dURLzGLIpmcIRQd5+9ifXH7n1cABWlRc+y91ETzBqiOJroQnEkcJa/NLWp6P9CuZ+tqzpKer5/Xu1+m26EHq03yuOjEcIMoJ25em7TRC/Ixsdn+Qh5SHXFLyDpy5E0zPK5JZ082bEh6rKuSDjhGxgpFa/zZtxdERmShHARrObR6k5U5o39CUrCQ82VOxt5XWmvUMApBtEpRCY6TI65KYlO7dfhlBZ31jeiI9XJbq/+PG5zJKCDvkIamvG1WdlG0HXSfB9lN44CGBYWsQnSsbOrZFALsCGjt/JyJ6h3ZfQz2849twOGQskpF5d4y+2bn0cQKbWz6RDCro
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QnGTIM6nhFjD5JeBYK2DMqB/Mkytvu0n3QCsjvC3hAEnyfdEYYRKDu//Q9zn?=
 =?us-ascii?Q?9fgs0D6WQgQFcuw5r9bUwduzMTKJv74gt1WbfzI01Ek7wjgsCSQkrb/6qU+A?=
 =?us-ascii?Q?M42E8ItVr9I6bvTV1ZNcsgqlCcEGs0d86HBsVb5m+v3PZws7j7u9deFbsM8V?=
 =?us-ascii?Q?jxY8MS4wcOhait7W9rN/xeklmGkv9srXEPl3BBAZfn3rItINpDfcDwGZPKGt?=
 =?us-ascii?Q?NfNPa6RKYRMIY67a9eine1YePdOKukAqrb7zG9e9HPbSRZLBPBTVd2zXNVaV?=
 =?us-ascii?Q?F61Y4Dg6b/91AMc1xQfPfwxhhsPjf6Eii9te11RISU4hpXEw8yeaUNzrt7Dg?=
 =?us-ascii?Q?JZ96fNUgBicu6hBhizDB34NVZjPcZVEWKUml1bsXr/zjiKSQ9fVcn6UNZCK9?=
 =?us-ascii?Q?SE3Onedu9SlN5S0OpAGpZrVi7+Rkec539GBUnI44EPkKJecpNTfV8sRca390?=
 =?us-ascii?Q?kd65YoLXdKhAiHdD+dYYpfTKvnsvyM3SrST6LqQCW7pg2+YLCTZqfXQDJmgM?=
 =?us-ascii?Q?k1D8UrqbVgFgOFfIVM5F9IYY/5ArrnWJd7IHnAunRK81tuvfwEIxS1L9L0I/?=
 =?us-ascii?Q?Nhfikgh8pbdebKSzpj4JeZECk23H0EzLufR32q1MuaJkhMt5k3xOuXYN44Zs?=
 =?us-ascii?Q?sJ0qZJnGzJjpzZuoblyrGVYqNZL+wgoOB71mjNA8yhMM2C+asD58KtSJbAj7?=
 =?us-ascii?Q?dVrN7bC7+vvtPkjP6atwTsrnd88o2urBOguYgV2wLkt5oW2XKVDTgmHIsM2t?=
 =?us-ascii?Q?6ynTCPf5G5IC8Ndrk94oY61rrDy7Oz3eEt/0MZV5I91/lfOPt3YNxF6rC1Cu?=
 =?us-ascii?Q?OQZbRxztiEVw8EHU9kVDJZ0Xdzfu6uSGzdYZDKA+4EvnsZNC2xWw/mIosVXQ?=
 =?us-ascii?Q?sgCQ00IIrfhWOOv36x3FZLFt+VAE6mOtJzrNPPQRRyXt+7jdxmwkPT2DNm1A?=
 =?us-ascii?Q?OioQZOCxX6l13QXsKU9DgoU+tbcZoM+7+c+byTDNbjOYr2M6XCJm/3RBrxxy?=
 =?us-ascii?Q?Y+kUyQ/kWsD3QOFxNjb8Bv/MM65Dl5WsWqS72cH3HUqZhfJ0VepSzZVoeIRr?=
 =?us-ascii?Q?Hlwp+B5S9ex1I2MFHahnNRzoxipS6d2ZNltOdn0b0t9WRl/IJomkNhfN7v/8?=
 =?us-ascii?Q?f/k62lSGruuSB42M0NXbkZpk3WX9tcOqgr3cpSasm18HIYfT+gXktx4BFacO?=
 =?us-ascii?Q?rheHR5rz34yJh5rr5Ewth3ejt2jlcGZRwW28VGOUpb8ELkLw4NAhtR8fqI4Q?=
 =?us-ascii?Q?l8ScmsouIY+48v+txFdzCaK3OiU5g9QM90lsVLf3Y04HOLUd4sVyGIRwraPF?=
 =?us-ascii?Q?k/pFPoRhAp4kBrnMLVWVnzfzchmJ4PrQ8pXCNOFXsJj0fLQI/2XkKk5VFkxI?=
 =?us-ascii?Q?xi2ov0aHZuzTFljClsOe/zc810Ha?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-10872.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 852230ac-eb07-4d51-4176-08de8f578213
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 18:58:34.2135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MM0P280MB0978
X-Spamd-Result: default: False [3.84 / 15.00];
	R_BAD_CTE_7BIT(3.50)[unknown];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34229-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,HOTMAIL.DE:dkim,GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM:mid]
X-Rspamd-Queue-Id: 6C6AF3704BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/21/26 10:42 PM, Christian Lamparter wrote:
> And the firmware just "delivers" the frame that it gets from the
> hardware. Apart from filtering (if enabled) it doesn't/shouldn't
> edit it.
>
> I don't think we can really tell? From what I know the antenna must
> have pick up this frame that way already. Is there some insight in
> how the hardware works?
> Note: This all might be because AR9170_MAC_RX_CTRL_PASS_TO_HOST is
> enabled.

Fair point. In 802.11b CCK the PLCP header rate field maps as follows:

  0x0a = 1 Mbps  (long preamble)
  0x14 = 2 Mbps
  0x37 = 5.5 Mbps
  0x6e = 11 Mbps

  0x05 = 2 Mbps  (short preamble)
  0x0b = 5.5 Mbps
  0x16 = 11 Mbps

0x00 is not a valid CCK rate in the 802.11b standard. Any frame
arriving with plcp[0] == 0x00 cannot be decoded to a real rate, so
the data payload is garbage regardless of the modulation path it
took through the hardware.

That said, you are right that we cannot tell whether this is a
hardware artefact, an RSSI-gated quirk of PASS_TO_HOST, or something
specific to the AR9170 PHY. The original `default:` case already
treated this as an error and the frame was dropped. This patch adds
an explicit case and keeps the same drop behaviour — the only
functional change is the wiphy_dbg downgrade for the genuine
`default:` path, which you already acked.

If you prefer, I can fold the 0x00 case back into the existing
`default:` case (without the dedicated comment) and just keep the
dbg downgrade. Let me know.

-- 
Regards,
Masi Osmani

