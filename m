Return-Path: <linux-wireless+bounces-34226-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDj+LGUZzGnHPgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34226-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 20:58:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FB2370482
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 20:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A5823006D6C
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 18:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4FB38F24D;
	Tue, 31 Mar 2026 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="RqbVMpge"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVZP280CU018.outbound.protection.outlook.com (mail-swedencentralazolkn19012051.outbound.protection.outlook.com [52.103.35.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208DC2FD7D3
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774983508; cv=fail; b=dtqu6o0AhoooezpMNhFfySlhJWo6+mYaca2r4LKoMViV5RAIW7nl2L8RSycdrGclNizbrs8R41ERsu3cLxzTtvx9BC5sAFqjrds2G6rx2Vajwn3JQNqQ8e0VdtYRJ20lMhy9dSTesy1+NmPeJZ14h8yr/E9gTHRwOJlv0yuzr1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774983508; c=relaxed/simple;
	bh=c9LspHNAJmhExADYgjayMHlbG/ryIssjsx2qM1z5KCI=;
	h=Date:Message-ID:From:To:CC:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tnksxu7YYYFEtk1+MMMOUSkgV5DZzcpihaC2UBoLoKX+dCd9AJskRAwEeKAKV0v7o0RgAr9TrTfvaoFUXIWtgtyfyB2dABLYVancEEQTuXqxJgVWxcg5anFPDX9k7eFPidy2KjPXLDcqgiyTHTo8OOB5MLPvSkvf1w5GhG7Sdoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=RqbVMpge; arc=fail smtp.client-ip=52.103.35.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fq0VRnJz8+rcUnu7mjH2fWkL0Mu0zs3N/etSrcLQKDGaAYnWQRQPhSLvueir0rA4ez5EPZbYMf6AsVR5CdJCs4E2q2uc3e1p5PV1mjQkK7uZgLjEKSKVyw3vYG/s9eeZMzUxptF2xDFwWDeEdy9vZBlJBW9SWmG8jKRCA6hBsFHc/MqEoBrnoclhDHpEIAmLtcfJdrPBn2hZZ2BtRlWS/QAGGQV94JmDGSaXlqWi+zFjGQPygv2ZvICokgTk4Mazw94DsY3ZloBIK4JRhNj07V0SI23oNKl6y2IBMVk4R8vW2MA7t6H/R5J9cs5KZycAsy3GkKJa2zYE5hAhB8992g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IRTHnt7evcz0AAcpWxtgWdwdGYbsp+wcipNWT28j8A=;
 b=bQ0JG+DsLSyRp+2h0gxBbQ9ukVDIQxP0MJhbnEKerPmPAUUFNWpFmgFoT72CB2Eo4NLTX2yV4kMKKm1Km4ITC3LFvDVVgd1hEMk9nNeXqgDPKeNZnkpcGPFEBZhkYsVR7Mor22D5FHK740gHPtJT8vNMM/m2QbNzayxOf3HakANYARaf+AQ3vqg3zdT9C97YgVNLXC2JSDte+EmQoxkNs78ArbgNE8yKNwkvjSl+Ioxt8afXl4sapkTie+MiO4JJPyfkQnrUXUeh7xr5bWKKEFgnnv/w2Rggro4i/mQEsdGMVWe7Yson7HZx/XWrcF/fUNy61eDnQyrhcNcPn/stDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IRTHnt7evcz0AAcpWxtgWdwdGYbsp+wcipNWT28j8A=;
 b=RqbVMpgeijiIUSd1Fwc0MHEWEvuHBtauKQ7tppdtO3Ig7d/T7R27n1j8I2PkM10+vChjzUju//r2rKhpprGb130z8ripdIY3nwH9/eJTC05z4Vyj9WIV4odT9rdFvA0v8Ldf0tLa7Kxa2ibiFq2AZFgu7peji6ueH8XQnrqNZwZNLUfP1K71/uOqiMXdfvsfFeo4FjNAsuDVubPqXYu+7AxynIUqj7192MOSblGYf/aDXIm+u2GJnv4nBQDFuhP4CRl2M5O60YgZBjW4a9R5H8tMKqZ8D+HHBAEgKQ29c4VqkPsQVqGAH2zaa/lgnL1IZRkeuFF2JMvg75rTIPSmXA==
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:19b::9)
 by MM0P280MB0978.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 18:58:24 +0000
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f]) by GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f%4]) with mapi id 15.20.9723.018; Tue, 31 Mar 2026
 18:58:24 +0000
Date: Tue, 31 Mar 2026 20:58:22 +0200
Message-ID:
 <GVYP280MB151861B23F19A6CE7F38E2699453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@gmail.com>
CC: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Subject: Re: [PATCH 07/10] carl9170: main: add exponential restart backoff
In-Reply-To: <a92b853c-fc20-4c6e-b587-ffa8f0f66ba4@gmail.com>
References: <AM7PPF5613FA0B6C3933233D4272D36007C9444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM> <a92b853c-fc20-4c6e-b587-ffa8f0f66ba4@gmail.com>
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::9) To GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:19b::9)
X-Microsoft-Original-Message-ID: <422056a26444a77c311a3344d5c0ba42@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1518:EE_|MM0P280MB0978:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f1e0669-f729-4dac-7073-08de8f577c04
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|19110799012|461199028|8060799015|15080799012|51005399006|5072599009|440099028|3412199025|26121999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	Skme5ttGP09DZrYdOOW030pGC476vo7dwZnyzI+PjOgbJLdEtqmJ5JjpcW3sB0h9GYBWgXR/qczsq6p4UNqlwRmc2F/ho3QR03/wosizrz3OeZrn84UOpHnKRYoGugRARMKannAdqOLW45r4VrFIwdpiInY+gBqjTLlPqBJqaVcFy3tUxPwN3KBAObJEaSXDa8Qn8il/QMqYVyguk7QBc3Feq0b9v57Qsp+rFoiv6MHAWw8Ad8UrwwrvV0hUlNzmKhx1c2YEYA7WUUXGpZ0rnFhNPjSel4ncPAO2Q8u3cEHmX4jrt4q6TCGy357QW24C/tJwMud2SLt+IZ+1j9LGzt7Rg65stVY/Jo2W6Nnikepbq2aoafIHgKo1mqwyDVP5INHda0+Wd49wdRWmEAvL31e4N44KFE2iqtXSiFk1lJrLWwDuJZuxRMvq/bYPeuf8yGx7ScpLYqnYfknfmnxo5SOaMYhJvhuglvB1FMkDMY09RhAwgHrBDEd7Enk6pv5HP+81ZNXyZ78nAKshAOys+ht+X94NShjWnNFnY4sqdiQ6xuDECJj/LUjOe2IV1ufpyec9QyJbwvIUaJOA57IlorCf50Y5aUWY4qSxNuGocF2lQBDvtjiKglWmKj139U4YDkhSkWelm/Xp1FQhAe/glHHtd8hbbSHGFcdp+o5toJDodF838bBbns7XQg8AhcYdRZkspe7FmLz1bQ51R8w6RuwH0OU0aDw0HRvT0VBi63+WPgNmtKdgnhrF9RucgCCdeHBpuyXwli9+mXaRpPnroToYuiOfdFE2f0E90m7YnSk/tmQZVaVKgHq4XGmA06QBF2/eI0TnXuS4NsBxB7wfYGDAgaO30aWQaL/8mNhrrr/XPOABkEO0C2jVdT/buURzzjZ5gyLE5hDMKuO5qRfcvf13pNoba2XSnyPt66xmbRR2Ix+IUhH0TCIhwleTNXTM
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DbOo/kXTKr2+5TAYRwGm43JdAwciJUbYbmKXiJSeygRZ39jsyja3kdC67ZIJ?=
 =?us-ascii?Q?ekg/WBn6W/brEf68xRx5vMA/WZh9HJ2i7X/istvsguKH43ElvMV0wt5uJoLl?=
 =?us-ascii?Q?GnyYkP/xeMKzVnakezkXHJBgNb3sqMYIorKc2qNPK/4GBIYZPXD3bzxMg8to?=
 =?us-ascii?Q?1FwjcUjmPyp65NcN3mE5he85Qgfx2pPsfitnDBSHcsDeIJWOhmZJsoEd8btr?=
 =?us-ascii?Q?OoWt6ghi6MSAcfWs+qmD2xAjPTGvHRxAHIQTD1WLWU9352pU8nbu+qxxXp56?=
 =?us-ascii?Q?BXh97PVOlgO6Pl/G2JDpiAMiLRqbNscyeBeOPvtuEtNaynoOjKFEJcyVT0Xa?=
 =?us-ascii?Q?PXC5kbYquVxODNghO9G8H0MjetlnjvxXP089Ht+KY+zVrSX/q2FaaSr0SvUN?=
 =?us-ascii?Q?VAXcKosY3wAUHzr6cjhRLg/e4jzTGRbvCqpo4w7sqRFgQCeP4/9DBSO+Tc5b?=
 =?us-ascii?Q?Zxp3+8RIjQZ3oPscGNlYCjwLlLxNBgZuDAeLlxGfGpRUt3PyvNE0KZQORo3a?=
 =?us-ascii?Q?IWEAbOUz5cxcD0syfzb44LuHO68cv5hZ1rvx2h/VAUtnFKkbxa/QPffJ2ipC?=
 =?us-ascii?Q?I+/jIAO4DQm+ODMaObEOjCgjPXe2e2p7Tplsuk4/Iowe+BtHJlgWrutticYj?=
 =?us-ascii?Q?/4GNPxoARphvxxT3ttGEfcROMr5TMh51g0VfFjruzrVYaHQtM9tIvtjFzEJm?=
 =?us-ascii?Q?HlMjr7mR+j2/h0YMWyE0rRdSZJf1ZN1EfWJHxvjj50FdYWIqhkpRCkEHb6mk?=
 =?us-ascii?Q?KbfmWEQRsg+dY9zztdacSn5g+FbrfDJhO2ib9LfOkR1yEFQF35qfZJewwuzM?=
 =?us-ascii?Q?pGv7t+taJwyvgCZ4xljkFuHNTQIhB2itlEBzfBN0mgaRzMMsmS+fciq3jzBg?=
 =?us-ascii?Q?Vqv+Kqx0EIO3He7AmTJCUOwW+k4ICNYmFmxE6ylqmgO9zbXoW3as88vdrnbr?=
 =?us-ascii?Q?BHpHo5Z0dagb03Rzx37qvEBdesHZhrvEPZd1zhtdlfz5cB7nGJYdKxMrJC+/?=
 =?us-ascii?Q?42E2dhsaJaY13CEkUw8M0dCgJVUt2RkJY8eqOnjAf048uh9BNN1OBis/aB2f?=
 =?us-ascii?Q?AXz70Sy36HvkrTPs/vBhDwSaVqADARP8XuAQfg5A9TflecvpdJpkjNtvGwOw?=
 =?us-ascii?Q?GLdojvReH8pDYH4HJZeeGb+bHhKknnmUc6MJTX81Ao7G2pkkSqgGNvJ1w87J?=
 =?us-ascii?Q?ckbstKLZ9smEXv44DHhL73POeGT4m2U9oSakvjjceNM9QtuzhdqryO3B5eLJ?=
 =?us-ascii?Q?TUbIxAbsF2TC5OC5yDofHyXFJ9PfyjgA5lDPbPvUwNtso0d92SkaVvWg24N9?=
 =?us-ascii?Q?fQeqS2eKbHKRXoaHChueWRUXJiaQJGBxlq+wIE+8frlYFrHlG/oahYWPnwYs?=
 =?us-ascii?Q?tfDBTZltoJgBgJVzxe8a4C+n13ms?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-10872.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1e0669-f729-4dac-7073-08de8f577c04
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 18:58:24.0915
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34226-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,HOTMAIL.DE:dkim,GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM:mid]
X-Rspamd-Queue-Id: C6FB2370482
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/21/26 9:42 PM, Christian Lamparter wrote:
> I guess you are refering with "window-based counting" to the
> CARL9170_FW_ERROR_WINDOW_MS ? But is it used anywhere?
> Maybe part of the patch is missing, or is there another patch?
>
> Otherwise, I would be inclined to test this out (in other words: ack it).

You are correct on both counts.

CARL9170_FW_ERROR_WINDOW_MS is defined but never wired up — the window-
based counting did not make it into the final patch. That constant is dead
code and should be removed.

Also, the change from `> 3` to `>= CARL9170_FW_ERROR_THRESHOLD` (where
CARL9170_FW_ERROR_THRESHOLD = 3) changes the trigger point from 4 errors
to 3. That is an unintentional off-by-one. I will set the threshold to 4
to preserve the original behaviour, or alternatively keep 3 and document
the intentional tightening — whichever you prefer.

I will send a v2 with both fixes:
- Remove CARL9170_FW_ERROR_WINDOW_MS (dead constant)
- Set CARL9170_FW_ERROR_THRESHOLD = 4 to match the original > 3 behaviour

-- 
Regards,
Masi Osmani

