Return-Path: <linux-wireless+bounces-8345-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B41B8D6309
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 15:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B58A0B2483F
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 13:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBC733CF1;
	Fri, 31 May 2024 13:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=carrierzone.com header.i=@carrierzone.com header.b="bdUjIhnA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail549c25.carrierzone.com (mail549c25.carrierzone.com [64.29.147.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A11B74BF0
	for <linux-wireless@vger.kernel.org>; Fri, 31 May 2024 13:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.29.147.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717162336; cv=none; b=kQxdUWObbHTIuqCkuqfU7DeF66euL9cXGNaQ0LRN/cnp4dseVDBHiL9R4xv8Dbrm81zep8S3ZhjRDYSX6zXqu3bdi9wfi8tsouiSikW7QV0DIBm9jYf/jyX2PX1pXsMXLWqc3PeRjb/2PXViQY0Dgd63iwlTDX6c8Ad/dkwpyNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717162336; c=relaxed/simple;
	bh=Xvy2ojDT1DU8LU/LD90gVadReHIb0DU1HOmR1e3YLrM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lprb/kbVtnPE4KgoaLWmQ3ROj6Wc/ENWInDuOhiHzB0bM9IARf9lLPRSttFzOIqFMZLTz2W0VW2C8J1Bq/P2XqySd67Za1E5ezb/g3/XwQWF4kveL86nXaJlM5SgUmr1eX/ll5a6YL8+Lrhim1wFfXB/bXCVL9gXq+Q5QlxKxNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hindutool.com; spf=none smtp.mailfrom=hindutool.com; dkim=pass (1024-bit key) header.d=carrierzone.com header.i=@carrierzone.com header.b=bdUjIhnA; arc=none smtp.client-ip=64.29.147.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hindutool.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hindutool.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=carrierzone.com;
	s=mailmia; t=1717161565;
	bh=Xvy2ojDT1DU8LU/LD90gVadReHIb0DU1HOmR1e3YLrM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:Reply-to:From;
	b=bdUjIhnAcCXqrrI29RcSaiSX+NxPYgSBbSkahQE70nyYoXzK2oyFsefbr84kbPS+Y
	 5BUP8Kd9+vgLp5Ii9mi5R/YG5qhrlsvDKwAzrVxodENpP9pwBbBvo4j5sVHG47efwV
	 UqwkDyflnIdQaKf0QTA8Lc2lwulE4mMLsVMsGqWE=
Feedback-ID:pgupta@hindutoo
Received: from mail549c25.carrierzone.com (localhost [127.0.0.1])
	by mail549c25.carrierzone.com (8.14.9/8.13.1) with ESMTP id 44VDJKLD012108
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 31 May 2024 13:19:20 +0000
Received: (from webmail@localhost)
	by mail549c25.carrierzone.com (8.14.9/8.12.2/Submit) id 44VDJKQq011966;
	Fri, 31 May 2024 09:19:20 -0400
From: "pgupta@hindutool.com" <pgupta@hindutool.com>
To: quic_hprem@quicinc.com, quic_jjohnson@quicinc.com, quic_bqiang@quicinc.com,
        ath12k@lists.infradead.org
CC: linux-wireless@vger.kernel.org
Subject: Re: [PATCH v7 0/8] wifi: ath12k: Introduce device group abstraction
Date: Fri, 31 May 2024 09:19:20 -0400
Message-ID: <1717161560.nw3mokq68g8og484@mailapp03.register.com>
In-Reply-To: <cc0fdf88-7046-eb93-265b-35a2d7299952@quicinc.com>
References: <20240528063547.1400700-1-quic_hprem@quicinc.com>
 <396d645d-6f3b-4c1b-9d4b-d056fad36192@quicinc.com>
 <7b92a6cd-187d-4b6d-8cfb-af54365751fc@quicinc.com>
 <d7898dd9-b3d2-45a1-8581-41d16b900a27@quicinc.com>
 <cc0fdf88-7046-eb93-265b-35a2d7299952@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Image-Url: https://mailapp03.register.com/api/storage/pgupta@hindutool.com/profile/picture
Reply-to: pgupta@hindutool.com
X-VADE-SPAMSTATE: clean
X-VADE-SPAMSCORE: 40
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdekiedgieduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffquffvqffrkfetpdfqfgfvpdfgpfggqdevvdehnecuuegrihhlohhuthemuceftddunecuogfuohhrthgvugftvggtihhpvdculdegtddmnecujfgurhephffvvefufffkjghfgggtgfhrsehtqhertddttdejnecuhfhrohhmpedfphhguhhpthgrsehhihhnughuthhoohhlrdgtohhmfdcuoehpghhuphhtrgeshhhinhguuhhtohholhdrtghomheqnecuggftrfgrthhtvghrnheptedtvdeiteekgeduheeitefhueekheetffethfdvjeffieejvdevvedvtedvgeehnecukfhppeduvdejrddtrddtrddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddphhgvlhhopehmrghilhehgeeltgdvhedrtggrrhhrihgvrhiiohhnvgdrtghomhdpmhgrihhlfhhrohhmpehpghhuphhtrgeshhhinhguuhhtohholhdrtghomhdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrthhhuddvkheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehquhhitggpsghqihgrnhhgsehquhhitghinhgtrdgtohhmpdhrtghpthhtohepqhhuihgtpghjjhhohhhnshhonhesqhhuihgtihhntgdrtghomhdprhg!
 tphhtthhopehquhhitggphhhprhgvmhesqhhuihgtihhntgdrtghomh
X-Rspamd-Status: No, score=0.90
X-Rspamd-Result: default: False [0.90 / 6.00];
	FROM_DN_EQ_ADDR(1.00)[];
	MIME_GOOD(-0.10)[text/plain];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	HAS_REPLYTO(0.00)[pgupta@hindutool.com];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Origin-Country: Unknown

Is there a limit to the number of hardware abstraction layers? My current p=
latform has 3 physical WiFi 7 modules in one machine - one for each frequen=
cy 2.4 GHz, 5 GHz, and 6GHz.  Is this currently not supported?=C2=A0
What if I want to connect more than 3 modules including identical modules o=
f the same frequency? My setup will not be utilizing combined frequency mod=
ules.
FYI, in my platform, each module is connected to its own PCIe slot, and has=
 its own antennas so I assume it would be recognized as its own wireless de=
vice by the OS (i.e wlan0, wlan1, wlan2, etc.).

I ask this question because my WiFi7 module manufacturer (Compex) informed =
me that multiple modules (either different frequencies or same frequencies)=
 in the same machine is not supported by ath12k at this time.
Sorry for the intrusion.

Prashant Gupta


On Fri, 31 May 2024 15:35:24 +0530, Harshitha Prem <quic_hprem@quicinc.com>=
 wrote:

>> On 5/30/2024 3:58 AM, Jeff Johnson wrote:
>> > On 5/28/2024 8:13 PM, Baochen Qiang wrote:
>> >>
>> >>
>> >> On 5/29/2024 6:04 AM, Jeff Johnson wrote:
>> >>> On 5/27/2024 11:35 PM, Harshitha Prem wrote:
>> >>>> To support multi-link operation, multiple devices with different ba=
nds say
>> >>>> 2 GHz or 5 GHz or 6 GHz can be combined together as a group and pro=
vide
>> >>>> an abstraction to mac80211.
>> >>>>
>> >>>> Device group abstraction - when there are multiple devices that are
>> >>>> connected by any means of communication interface between them, the=
n these
>> >>>> devices can be combined together as a single group using a group id=
 to form
>> >>>> a group abstraction. In ath12k driver, this abstraction would be na=
med as
>> >>>> ath12k_hw_group (ag).
>> >>>>
>> >>>> Please find below illustration of device group abstraction with two
>> >>>> devices.
>> >>>>
>> >>>> Grouping of multiple devices (in future)
>> >>>> +------------------------------------------------------------------=
------+
>> >>>> | +-------------------------------------+ +-------------------+ |
>> >>>> | | +-----------+ | | +-----------+ | | +-----------+ | |
>> >>>> | | | ar (2GHz) | | | | ar (5GHz) | | | | ar (6GHz) | | |
>> >>>> | | +-----------+ | | +-----------+ | | +-----------+ | |
>> >>>> | | ath12k_base (ab) | | ath12k_base (ab) | |
>> >>>> | | (Dual band device) | | | |
>> >>>> | +-------------------------------------+ +-------------------+ |
>> >>>> | ath12k_hw_group (ag) based on group id |
>> >>>> +------------------------------------------------------------------=
------+
>> >>>>
>> >>>> Say for example, device 1 has two radios (2 GHz and 5 GHz band) and
>> >>>> device 2 has one radio (6 GHz).
>> >>>>
>> >>>> In existing code -
>> >>>> device 1 will have two hardware abstractions hw1 (2 GHz) and hw2
>> >>>> (5 GHz) will be registered separately to mac80211 as phy0 and phy1
>> >>>> respectively. Similarly, device 2 will register its hw (6GHz) as
>> >>>> phy2 to mac80211.
>> >>>>
>> >>>> In future, with multi-link abstraction
>> >>>>
>> >>>> combination 1 - Different group id for device1 and device 2
>> >>>> Device 1 will create a single hardware abstraction hw1
>> >>>> (2 GHz and 5 GHz) and will be registered to mac80211 as
>> >>>> phy0. similarly, device 2 will register its hardware
>> >>>> (6 GHz) to mac80211 as phy1.
>> >>>>
>> >>>> combination 2 - Same group id for device1 and device 2
>> >>>> Both device details are combined together as a group, say
>> >>>> group1, with single hardware abstraction of radios 2 GHz,
>> >>>> 5 GHz and 6 GHz band details and will be registered to
>> >>>> mac80211 as phy0.
>> >>>>
>> >>>> Add base infrastructure changes to add device grouping abstraction =
with
>> >>>> a single device.
>> >>>>
>> >>>> This patch series brings the base code changes with following order=
:
>> >>>> 1. Refactor existing code which would facilitate in introducing
>> >>>> device group abstraction.
>> >>>> 2. Create a device group abstraction during device probe.
>> >>>> 3. Start the device group only after QMI firmware ready event is
>> >>>> received for all the devices that are combined in the group.
>> >>>> 4. Move the hardware abstractions (ath12k_hw - ah) from device
>> >>>> (ath12k_base - ab) to device group abstraction (ag) as it would
>> >>>> ease in having different combinations of group abstraction that
>> >>>> can be registered to mac80211.
>> >>>>
>> >>>> v7:
>> >>>> - Added linux-wireless mailer to cc.
>> >>>> - Removed Acked-by tag from "[PATCH v6 8/8]" as it has minor change=
=2E
>> >>>>
>> >>>> v6:
>> >>>> - Addressed smatch error seen on "[PATCH v5 8/8] wifi: ath12k: move
>> >>>> ath12k_hw from per soc to group"
>> >>>> - Rebased to ToT
>> >>>> v5:
>> >>>> - on "[PATCH 8/8] wifi: ath12k: move ath12k_hw from per soc to
>> >>>> group", refactor the ath12k_mac_hw_allocate() api based on ag rathe=
r
>> >>>> than ab and update hardware abstraction array size in ath12k_hw_gro=
up
>> >>>> as ATH12K_GROUP_MAX_RADIO.
>> >>>> - Rebased to ToT
>> >>>> v4:
>> >>>> - Modified the cover letter
>> >>>> v3:
>> >>>> - Removed depends-on tag of "wifi: ath12k: Refactor the hardware re=
covery
>> >>>> procedures" as it is merged to ToT
>> >>>> - Addressed the deadlock warning seen during rmmod.
>> >>>>
>> >>>> v2:
>> >>>> - Rebased to ToT
>> >>>>
>> >>>> Karthikeyan Periyasamy (8):
>> >>>> wifi: ath12k: Refactor core start api
>> >>>> wifi: ath12k: Add helpers to get or set ath12k_hw
>> >>>> wifi: ath12k: Add ath12k_get_num_hw api
>> >>>> wifi: ath12k: Introduce QMI firmware ready flag
>> >>>> wifi: ath12k: move ATH12K_FLAG_REGISTERED flag set to mac_register =
api
>> >>>> wifi: ath12k: Introduce device group abstraction
>> >>>> wifi: ath12k: refactor core start based on hardware group
>> >>>> wifi: ath12k: move ath12k_hw from per device to group
>> >>>>
>> >>>> drivers/net/wireless/ath/ath12k/core.c | 431 +++++++++++++++++++++-=
---
>> >>>> drivers/net/wireless/ath/ath12k/core.h | 87 ++++-
>> >>>> drivers/net/wireless/ath/ath12k/dp.c | 19 +-
>> >>>> drivers/net/wireless/ath/ath12k/dp.h | 2 +-
>> >>>> drivers/net/wireless/ath/ath12k/mac.c | 117 ++++---
>> >>>> drivers/net/wireless/ath/ath12k/mac.h | 9 +-
>> >>>> drivers/net/wireless/ath/ath12k/pci.c | 2 +
>> >>>> drivers/net/wireless/ath/ath12k/qmi.c | 10 +-
>> >>>> 8 files changed, 544 insertions(+), 133 deletions(-)
>> >>>>
>> >>>>
>> >>>> base-commit: f8320064a28242448eeb9fece08abd865ea8a226
>> >>>
>> >>> With this series I'm seeing a firmware crash upon resume from hibern=
ation, but
>> >>> I'm not sure if it is the same intermittent crash I reported in anot=
her thread
>> >>> where firmware is not correctly handling a low physical memory addre=
ss.
>> >>>
>> >>> Baochen & Kalle, since this issue may be specific to my laptop, can =
you
>> >>> validate hibernation on your setups?
>> >> I can also see a firmware crash upon resume. I am using ath-202405281=
746 as code base.
>> >
>> > I bisected to:
>> > [PATCH v7 7/8] wifi: ath12k: refactor core start based on hardware gro=
up
>> >
>> >
>> Thank you so much, Jeff. Identified the possible reason that is causing
>> the firmware assert with hibernation scenario and will address it in
>> next version.

