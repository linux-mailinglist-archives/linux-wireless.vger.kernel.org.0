Return-Path: <linux-wireless+bounces-13099-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEECB983D8E
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 09:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 207A8B22D92
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 07:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA98B12C544;
	Tue, 24 Sep 2024 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=technux.se header.i=@technux.se header.b="eqogrFch"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m101-out-mua-2.websupport.se (m101-out-mua-2.websupport.se [109.235.175.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFC112C52E
	for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2024 07:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.235.175.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727161595; cv=none; b=aIZ3BuWMNb+QSLaH9hb6R+YAV4P4cA25HfowCR7ZiKOb/ZwhPtsH+rL4SumQOv/zIRL8wCJLGqz+dKzW9mITyh+F3pkO2wEl5xJzLWWeygSVVuRPdrzCRbqbxA37e6tvugh4N1/YKrDesZxxGmfP7WDd7UhIPsvPUUkxv9rVAQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727161595; c=relaxed/simple;
	bh=99QIfBNLE1dq2tqfHKm3Jy7ZoRFcfTnBQK0mDnQqaQc=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type; b=SX5sg1vz4npTjUurkHQCNP0MTbgru2HUDVOTXAniKH0Gxv42CdTbrR79Wve09wErisqeRQ8pwdrmkoUuhHh9nfqEX9s9dMrZ5rDwkYUcjFd9XxUISsL1LD/hBW95E647AkhrHK9KNf/i+UXjt6tdcu1eKWbcveKmWhYlTAhxi6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=technux.se; spf=pass smtp.mailfrom=technux.se; dkim=pass (2048-bit key) header.d=technux.se header.i=@technux.se header.b=eqogrFch; arc=none smtp.client-ip=109.235.175.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=technux.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=technux.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=technux.se; s=mail;
	t=1727161589; bh=NTBC6WRkXsvx4h+QlRX9sxCksjEXtYTWfNP78mpCoj4=;
	h=Date:From:To:Cc:Subject:From;
	b=eqogrFchwvTurNJ+JY+/jRkZYKMdXFxpzdCWkcfY7sgstN28vv0o99wtfSFU7zY4u
	 qu2e+IErU6+MAs26Pl32o9Csk7uwSiTtCWyNjHnRLfPDTE1PIxUigRkD4nLHD7wonu
	 fdAGcvJN1cVVYaEhmo4IYZtCND7evNfF2+ExMiNhiRCvU0AA24wGvalAWDCye7TRXr
	 pRedRLTNi8gTJ0EMR77+BGp+VKzHO11zJGr/lwsH8MhUNqZd6KRZJTjGqRka3XcxdO
	 g9PBf/duepENoFPhFBDtY7MXZV5qAC1H225/4xpK7uh/bSZzkACpxl4e4Zw+PiNWg9
	 IRO1vg2XoNyqg==
Received: from m101-u6-ing.websupport.se (unknown [10.30.6.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by m101-out-mua-2.websupport.se (Postfix) with ESMTPS id 4XCW9x1ZNtz1cFy;
	Tue, 24 Sep 2024 09:06:29 +0200 (CEST)
X-Authenticated-Sender: petter@technux.se
Authentication-Results: m101-u6-ing.websupport.se;
	auth=pass smtp.auth=petter@technux.se smtp.mailfrom=petter@technux.se
Received: from roundcube.ws.int (unknown [109.235.175.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: petter@technux.se)
	by m101-u6-ing.websupport.se (Postfix) with ESMTPSA id 4XCW9w5zDHz1gMd;
	Tue, 24 Sep 2024 09:06:28 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 24 Sep 2024 09:06:28 +0200
From: petter@technux.se
To: linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com, rtl8821cerfe2@gmail.com, morrownr@gmail.com,
 s.hauer@pengutronix.de
Subject: rtw88: rtw8822cu: Kernel warning in cfg80211: disconnect_work at
 net/wireless/core.h:231 on CPU 0
User-Agent: Roundcube Webmail/1.6.9
Message-ID: <80de30f72595480a2e061dc462191c9f@technux.se>
X-Sender: petter@technux.se
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Out-Rspamd-Server: m101-rspamd-out-4
X-Out-Rspamd-Queue-Id: 4XCW9w5zDHz1gMd
X-Rspamd-Pre-Result: action=no action;
	module=multimap;
	Matched map: WS_IP_WHITELIST
X-Out-Spamd-Result: default: False [-0.10 / 1000.00];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	WS_IP_WHITELIST(0.00)[109.235.175.24];
	FROM_NO_DN(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:41528, ipnet:109.235.175.0/24, country:SE];
	FUZZY_BLOCKED(0.00)[rspamd.com]
X-Rspamd-Action: no action
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 20950
X-purgate-ID: 155908::1727161589-C578AF5A-D79E4DDA/0/0
Feedback-ID: m101:technux.se

Hi,

I have an issue with my 8822cu based usb device on >= 6.6 Linux with AP 
mode. Using latest changes AP-mode seems to work fairly good. But when 
enabling/disabling it I seems to always get below. It sometimes happens 
without using AP-mode also, when for example disconnection happens due 
to bad connection. Any ideas what might be causing this? Please also let 
me know if you want additional debugging logs etc.

BR Petter


```

[ 1429.886683] WARNING: CPU: 0 PID: 9 at net/wireless/core.h:231 
disconnect_work+0xb8/0x144 [cfg80211]
[ 1429.898367] Modules linked in: rtw88_8822cu rtw88_8822c rtw88_usb 
rtw88_core mac80211 libarc4 cfg80211 btusb btrtl btintel btbcm btmtk 
imx_sdma ip_tables x_tables
[ 1429.913362] CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted 
6.6.51-00141-ga1649b6f8ed6 #7
[ 1429.921228] Hardware name: Freescale i.MX6 SoloX (Device Tree)
[ 1429.927082] Workqueue: events disconnect_work [cfg80211]
[ 1429.933556]  unwind_backtrace from show_stack+0x10/0x14
[ 1429.938833]  show_stack from dump_stack_lvl+0x58/0x70
[ 1429.943922]  dump_stack_lvl from __warn+0x70/0x1c0
[ 1429.948759]  __warn from warn_slowpath_fmt+0x16c/0x294
[ 1429.953939]  warn_slowpath_fmt from disconnect_work+0xb8/0x144 
[cfg80211]
[ 1429.961935]  disconnect_work [cfg80211] from 
process_one_work+0x204/0x620
[ 1429.969851]  process_one_work from worker_thread+0x1b0/0x474
[ 1429.975549]  worker_thread from kthread+0x10c/0x12c
[ 1429.980461]  kthread from ret_from_fork+0x14/0x24
[ 1429.985194] Exception stack(0xf0855fb0 to 0xf0855ff8)
[ 1429.990268] 5fa0:                                     00000000 
00000000 00000000 00000000
[ 1429.998466] 5fc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[ 1430.006662] 5fe0: 00000000 00000000 00000000 00000000 00000013 
00000000
[ 1430.014300] irq event stamp: 1984773
[ 1430.017924] hardirqs last  enabled at (1984781): [<c019e8e0>] 
console_unlock+0x134/0x164
[ 1430.026190] hardirqs last disabled at (1984796): [<c019e8cc>] 
console_unlock+0x120/0x164
[ 1430.034412] softirqs last  enabled at (1984794): [<c012f3b4>] 
handle_softirqs+0x2ac/0x49c
[ 1430.042695] softirqs last disabled at (1984789): [<c012f74c>] 
__irq_exit_rcu+0x154/0x194
[ 1430.050941] ---[ end trace 0000000000000000 ]---
[ 1429.881452] ------------[ cut here ]------------
[ 1429.886683] WARNING: CPU: 0 PID: 9 at net/wireless/core.h:231 
disconnect_work+0xb8/0x144 [cfg80211]
[ 1429.898367] Modules linked in: rtw88_8822cu rtw88_8822c rtw88_usb 
rtw88_core mac80211 libarc4 cfg80211 btusb btrtl btintel btbcm btmtk 
imx_sdma ip_tables x_tables
[ 1429.913362] CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted 
6.6.51-00141-ga1649b6f8ed6 #7
[ 1429.921228] Hardware name: Freescale i.MX6 SoloX (Device Tree)
[ 1429.927082] Workqueue: events disconnect_work [cfg80211]
[ 1429.933556]  unwind_backtrace from show_stack+0x10/0x14
[ 1429.938833]  show_stack from dump_stack_lvl+0x58/0x70
[ 1429.943922]  dump_stack_lvl from __warn+0x70/0x1c0
[ 1429.948759]  __warn from warn_slowpath_fmt+0x16c/0x294
[ 1429.953939]  warn_slowpath_fmt from disconnect_work+0xb8/0x144 
[cfg80211]
[ 1429.961935]  disconnect_work [cfg80211] from 
process_one_work+0x204/0x620
[ 1429.969851]  process_one_work from worker_thread+0x1b0/0x474
[ 1429.975549]  worker_thread from kthread+0x10c/0x12c
[ 1429.980461]  kthread from ret_from_fork+0x14/0x24
[ 1429.985194] Exception stack(0xf0855fb0 to 0xf0855ff8)
[ 1429.990268] 5fa0:                                     00000000 
00000000 00000000 00000000
[ 1429.998466] 5fc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[ 1430.006662] 5fe0: 00000000 00000000 00000000 00000000 00000013 
00000000
[ 1430.014300] irq event stamp: 1984773
[ 1430.017924] hardirqs last  enabled at (1984781): [<c019e8e0>] 
console_unlock+0x134/0x164
[ 1430.026190] hardirqs last disabled at (1984796): [<c019e8cc>] 
console_unlock+0x120/0x164
[ 1430.034412] softirqs last  enabled at (1984794): [<c012f3b4>] 
handle_softirqs+0x2ac/0x49c
[ 1430.042695] softirqs last disabled at (1984789): [<c012f74c>] 
__irq_exit_rcu+0x154/0x194
[ 1430.050941] ---[ end trace 0000000000000000 ]---
[ 1430.305675] ------------[ cut here ]------------
[ 1430.310778] WARNING: CPU: 0 PID: 9 at net/wireless/core.h:246 
cfg80211_beaconing_iface_active+0x124/0x144 [cfg80211]
[ 1430.322835] Modules linked in: rtw88_8822cu rtw88_8822c rtw88_usb 
rtw88_core mac80211 libarc4 cfg80211 btusb btrtl btintel btbcm btmtk 
imx_sdma ip_tables x_tables
[ 1430.338134] CPU: 0 PID: 9 Comm: kworker/0:1 Tainted: G        W       
    6.6.51-00141-ga1649b6f8ed6 #7
[ 1430.347480] Hardware name: Freescale i.MX6 SoloX (Device Tree)
[ 1430.353333] Workqueue: events disconnect_work [cfg80211]
[ 1430.359806]  unwind_backtrace from show_stack+0x10/0x14
[ 1430.365085]  show_stack from dump_stack_lvl+0x58/0x70
[ 1430.370173]  dump_stack_lvl from __warn+0x70/0x1c0
[ 1430.375009]  __warn from warn_slowpath_fmt+0x16c/0x294
[ 1430.380190]  warn_slowpath_fmt from 
cfg80211_beaconing_iface_active+0x124/0x144 [cfg80211]
[ 1430.389659]  cfg80211_beaconing_iface_active [cfg80211] from 
disconnect_work+0x100/0x144 [cfg80211]
[ 1430.400855]  disconnect_work [cfg80211] from 
process_one_work+0x204/0x620
[ 1430.408749]  process_one_work from worker_thread+0x1b0/0x474
[ 1430.414448]  worker_thread from kthread+0x10c/0x12c
[ 1430.419361]  kthread from ret_from_fork+0x14/0x24
[ 1430.424099] Exception stack(0xf0855fb0 to 0xf0855ff8)
[ 1430.429173] 5fa0:                                     00000000 
00000000 00000000 00000000
[ 1430.437373] 5fc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[ 1430.445571] 5fe0: 00000000 00000000 00000000 00000000 00000013 
00000000
[ 1430.452992] irq event stamp: 1985081
[ 1430.456613] hardirqs last  enabled at (1985089): [<c019e8e0>] 
console_unlock+0x134/0x164
[ 1430.464878] hardirqs last disabled at (1985110): [<c019e8cc>] 
console_unlock+0x120/0x164
[ 1430.473098] softirqs last  enabled at (1985108): [<c012f3b4>] 
handle_softirqs+0x2ac/0x49c
[ 1430.481324] softirqs last disabled at (1985097): [<c012f74c>] 
__irq_exit_rcu+0x154/0x194
[ 1430.489554] ---[ end trace 0000000000000000 ]---
[ 1430.305675] ------------[ cut here ]------------
[ 1430.310778] WARNING: CPU: 0 PID: 9 at net/wireless/core.h:246 
cfg80211_beaconing_iface_active+0x124/0x144 [cfg80211]
[ 1430.322835] Modules linked in: rtw88_8822cu rtw88_8822c rtw88_usb 
rtw88_core mac80211 libarc4 cfg80211 btusb btrtl btintel btbcm btmtk 
imx_sdma ip_tables x_tables
[ 1430.338134] CPU: 0 PID: 9 Comm: kworker/0:1 Tai[ 1430.529638] 
------------[ cut here ]------------
nted: G        W          6.6.51-[ 1430.536236] WARNING: CPU: 0 PID: 9 
at net/wireless/core.h:239 disconnect_work+0xe4/0x144 [cfg80211]
00141-ga1649b6f8ed6 #7
[ 1430.34[ 1430.548209] Modules linked in: rtw88_8822cu rtw88_8822c 
rtw88_usb rtw88_core mac80211 libarc4 cfg80211 btusb btrtl btintel btbcm 
btmtk imx_sdma ip_tables x_tables
7480] Hardware name: Freescale i.[ 1430.565496] CPU: 0 PID: 9 Comm: 
kworker/0:1 Tainted: G        W          6.6.51-00141-ga1649b6f8ed6 #7
[ 1430.577478] Hardware name: Freescale i.MX6 SoloX (Device Tree)
[ 1430.583331] Workqueue: events disconnect_work [cfg80211]
[ 1430.589790]  unwind_backtrace from show_stack+0x10/0x14
[ 1430.595069]  show_stack from dump_stack_lvl+0x58/0x70
[ 1430.600157]  dump_stack_lvl from __warn+0x70/0x1c0
[ 1430.604994]  __warn from warn_slowpath_fmt+0x16c/0x294
[ 1430.610177]  warn_slowpath_fmt from disconnect_work+0xe4/0x144 
[cfg80211]
[ 1430.618095]  disconnect_work [cfg80211] from 
process_one_work+0x204/0x620
[ 1430.625989]  process_one_work from worker_thread+0x1b0/0x474
[ 1430.631687]  worker_thread from kthread+0x10c/0x12c
[ 1430.636602]  kthread from ret_from_fork+0x14/0x24
[ 1430.641335] Exception stack(0xf0855fb0 to 0xf0855ff8)
[ 1430.646412] 5fa0:                                     00000000 
00000000 00000000 00000000
[ 1430.654610] 5fc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[ 1430.662807] 5fe0: 00000000 00000000 00000000 00000000 00000013 
00000000
MX6 SoloX (Device Tree)
[ 1430.3[ 1430.670230] irq event stamp: 1985387
53333] Workqueue: events disconne[ 1430.676059] hardirqs last  enabled 
at (1985407): [<c019e8e0>] console_unlock+0x134/0x164
ct_work [cfg80211]
[ 1430.359806[ 1430.686982] hardirqs last disabled at (1985416): 
[<c019e8cc>] console_unlock+0x120/0x164
]  unwind_backtrace from show_sta[ 1430.697999] softirqs last  enabled 
at (1985404): [<c012f3b4>] handle_softirqs+0x2ac/0x49c
ck+0x10/0x14
[ 1430.365085]  sho[ 1430.709105] softirqs last disabled at (1985395): 
[<c012f74c>] __irq_exit_rcu+0x154/0x194
w_stack from dump_stack_lvl+0x58/[ 1430.720445] ---[ end trace 
0000000000000000 ]---
0x70
[ 1430.370173]  dump_stack_lvl from __warn+0x70/0x1c0
[ 1430.375009]  __warn from warn_slowpath_fmt+0x16c/0x294
[ 1430.380190]  warn_slowpath_fmt from 
cfg80211_beaconing_iface_active+0x124/0x144 [cfg80211]
[ 1430.389659]  cfg80211_beaconing_iface_active [cfg80211] from 
disconnect_work+0x100/0x144 [cfg80211]
[ 1430.400855]  disconnect_work [cfg802[ 1430.757591] ------------[ cut 
here ]------------
11] from process_one_work+0x204/0[ 1430.763348] WARNING: CPU: 0 PID: 9 
at net/wireless/core.h:231 is_wiphy_all_set_reg_flag+0xb4/0x144 
[cfg80211]
x620
[ 1430.408749]  process_one[ 1430.776198] Modules linked in: 
rtw88_8822cu rtw88_8822c rtw88_usb rtw88_core mac80211 libarc4 cfg80211 
btusb btrtl btintel btbcm btmtk imx_sdma ip_tables x_tables
_work from worker_thread+0x1b0/0x[ 1430.793594] CPU: 0 PID: 9 Comm: 
kworker/0:1 Tainted: G        W          6.6.51-00141-ga1649b6f8ed6 #7
[ 1430.805471] Hardware name: Freescale i.MX6 SoloX (Device Tree)
[ 1430.811324] Workqueue: events disconnect_work [cfg80211]
[ 1430.817785]  unwind_backtrace from show_stack+0x10/0x14
[ 1430.823062]  show_stack from dump_stack_lvl+0x58/0x70
[ 1430.828150]  dump_stack_lvl from __warn+0x70/0x1c0
[ 1430.832986]  __warn from warn_slowpath_fmt+0x16c/0x294
[ 1430.838167]  warn_slowpath_fmt from 
is_wiphy_all_set_reg_flag+0xb4/0x144 [cfg80211]
[ 1430.846957]  is_wiphy_all_set_reg_flag [cfg80211] from 
regulatory_hint_disconnect+0xc/0xdc [cfg80211]
[ 1430.858313]  regulatory_hint_disconnect [cfg80211] from 
disconnect_work+0x130/0x144 [cfg80211]
[ 1430.869050]  disconnect_work [cfg80211] from 
process_one_work+0x204/0x620
[ 1430.876943]  process_one_work from worker_thread+0x1b0/0x474
[ 1430.882642]  worker_thread from kthread+0x10c/0x12c
[ 1430.887554]  kthread from ret_from_fork+0x14/0x24
[ 1430.892290] Exception stack(0xf0855fb0 to 0xf0855ff8)
[ 1430.897364] 5fa0:                                     00000000 
00000000 00000000 00000000
[ 1430.905561] 5fc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[ 1430.913760] 5fe0: 00000000 00000000 00000000 00000000 00000013 
00000000
474
[ 1430.414448]  worker_threa[ 1430.921569] irq event stamp: 1985873
d from kthread+0x10c/0x12c
[ 143[ 1430.927055] hardirqs last  enabled at (1985911): [<c019e8e0>] 
console_unlock+0x134/0x164
0.419361]  kthread from ret_from_[ 1430.938018] hardirqs last disabled 
at (1985920): [<c019e8cc>] console_unlock+0x120/0x164
fork+0x14/0x24
[ 1430.424099] Ex[ 1430.949023] softirqs last  enabled at (1985908): 
[<c012f3b4>] handle_softirqs+0x2ac/0x49c
ception stack(0xf0855fb0 to 0xf08[ 1430.959991] softirqs last disabled 
at (1985881): [<c012f74c>] __irq_exit_rcu+0x154/0x194
55ff8)
[ 1430.429173] 5fa0:     [ 1430.970888] ---[ end trace 0000000000000000 
]---
                                 00000000 00000000 00000000 00000000
[ 1430.437373] 5fc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[ 1430.445571] 5fe0: 00000000 00000000 00000000 00000000 00000013 
00000000
[ 1430.452992] irq event stamp: 1985081
[ 1430.456613] hardirqs last  enabled at (1985089): [<c019e8e0>] 
console_unlock+0x134/0x164
[ 1430.464878] hardirqs last disabled a[ 1431.012846] ------------[ cut 
here ]------------
t (1985110): [<c019e8cc>] console[ 1431.019064] WARNING: CPU: 0 PID: 9 
at net/wireless/core.h:239 is_wiphy_all_set_reg_flag+0x134/0x144 
[cfg80211]
_unlock+0x120/0x164
[ 1430.47309[ 1431.031956] Modules linked in: rtw88_8822cu rtw88_8822c 
rtw88_usb rtw88_core mac80211 libarc4 cfg80211 btusb btrtl btintel btbcm 
btmtk imx_sdma ip_tables x_tables
8] softirqs last  enabled at (198[ 1431.049154] CPU: 0 PID: 9 Comm: 
kworker/0:1 Tainted: G        W          6.6.51-00141-ga1649b6f8ed6 #7
[ 1431.061186] Hardware name: Freescale i.MX6 SoloX (Device Tree)
[ 1431.067039] Workqueue: events disconnect_work [cfg80211]
[ 1431.073498]  unwind_backtrace from show_stack+0x10/0x14
[ 1431.078776]  show_stack from dump_stack_lvl+0x58/0x70
[ 1431.083865]  dump_stack_lvl from __warn+0x70/0x1c0
[ 1431.088701]  __warn from warn_slowpath_fmt+0x16c/0x294
[ 1431.093883]  warn_slowpath_fmt from 
is_wiphy_all_set_reg_flag+0x134/0x144 [cfg80211]
[ 1431.102757]  is_wiphy_all_set_reg_flag [cfg80211] from 
regulatory_hint_disconnect+0xc/0xdc [cfg80211]
[ 1431.114098]  regulatory_hint_disconnect [cfg80211] from 
disconnect_work+0x130/0x144 [cfg80211]
[ 1431.124831]  disconnect_work [cfg80211] from 
process_one_work+0x204/0x620
[ 1431.132724]  process_one_work from worker_thread+0x1b0/0x474
[ 1431.138423]  worker_thread from kthread+0x10c/0x12c
[ 1431.143335]  kthread from ret_from_fork+0x14/0x24
[ 1431.148070] Exception stack(0xf0855fb0 to 0xf0855ff8)
[ 1431.153144] 5fa0:                                     00000000 
00000000 00000000 00000000
[ 1431.161341] 5fc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[ 1431.169539] 5fe0: 00000000 00000000 00000000 00000000 00000013 
00000000
5108): [<c012f3b4>] handle_softir[ 1431.176768] irq event stamp: 1986265
qs+0x2ac/0x49c
[ 1430.481324] so[ 1431.182674] hardirqs last  enabled at (1986275): 
[<c019e8e0>] console_unlock+0x134/0x164
ftirqs last disabled at (1985097)[ 1431.193819] hardirqs last disabled 
at (1986284): [<c019e8cc>] console_unlock+0x120/0x164
: [<c012f74c>] __irq_exit_rcu+0x1[ 1431.205066] softirqs last  enabled 
at (1986314): [<c012f3b4>] handle_softirqs+0x2ac/0x49c
54/0x194
[ 1430.489554] ---[ end[ 1431.215769] softirqs last disabled at 
(1986293): [<c012f74c>] __irq_exit_rcu+0x154/0x194
  trace 0000000000000000 ]---
[ 1[ 1431.226678] ---[ end trace 0000000000000000 ]---
430.529638] ------------[ cut here ]------------
[ 1430.536236] WARNING: CPU: 0 PID: 9 at net/wireless/core.h:239 
disconnect_work+0xe4/0x144 [cfg80211]
[ 1430.548209] Modules linked in: rtw88_8822cu rtw88_8822c rtw88_usb 
rtw88_core mac80211 libarc4 cfg80211 btusb btrtl btintel btbcm btmtk 
imx_sdma ip_tables x_tables
[ 1430.565496] CPU: 0 PID: 9 Comm: kworker/0:1 Tainted: G        W       
    6.6.51-00141-ga1649b6f8ed6 #7
[ 1430.577478] Hardware name: Freescale i.MX6 SoloX (Device Tree)
[ 1430.583331] Workqueue: events disconnect_work [cfg80211]
[ 1430.589790]  unwind_backtrace from show_stack+0x10/0x14
[ 1430.595069]  show_stack from dump_stack_lvl+0x58/0x70
[ 1430.600157]  dump_stack_lvl from __warn+0x70/0x1c0
[ 1430.604994]  __warn from warn_slowpath_fmt+0x16c/0x294
[ 1430.610177]  warn_slowpath_fmt from disconnect_work+0xe4/0x144 
[cfg80211]
[ 1430.618095]  disconnect_work [cfg80211] from 
process_one_work+0x204/0x620
[ 1430.625989]  process_one_work from worker_thread+0x1b0/0x474
[ 1430.631687]  worker_thread from kthread+0x10c/0x12c
[ 1430.636602]  kthread from ret_from_fork+0x14/0x24
[ 1430.641335] Exception stack(0xf0855fb0 to 0xf0855ff8)
[ 1430.646412] 5fa0:                                     00000000 
00000000 00000000 00000000
[ 1430.654610] 5fc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[ 1430.662807] 5fe0: 00000000 00000000 00000000 00000000 00000013 
00000000
[ 1430.670230] irq event stamp: 1985387
[ 1430.676059] hardirqs last  enabled at (1985407): [<c019e8e0>] 
console_unlock+0x134/0x164
[ 1430.686982] hardirqs last disabled at (1985416): [<c019e8cc>] 
console_unlock+0x120/0x164
[ 1430.697999] softirqs last  enabled at (1985404): [<c012f3b4>] 
handle_softirqs+0x2ac/0x49c
[ 1430.709105] softirqs last disabled at (1985395): [<c012f74c>] 
__irq_exit_rcu+0x154/0x194
[ 1430.720445] ---[ end trace 0000000000000000 ]---
[ 1430.757591] ------------[ cut here ]------------
[ 1430.763348] WARNING: CPU: 0 PID: 9 at net/wireless/core.h:231 
is_wiphy_all_set_reg_flag+0xb4/0x144 [cfg80211]
[ 1430.776198] Modules linked in: rtw88_8822cu rtw88_8822c rtw88_usb 
rtw88_core mac80211 libarc4 cfg80211 btusb btrtl btintel btbcm btmtk 
imx_sdma ip_tables x_tables
[ 1430.793594] CPU: 0 PID: 9 Comm: kworker/0:1 Tainted: G        W       
    6.6.51-00141-ga1649b6f8ed6 #7
[ 1430.805471] Hardware name: Freescale i.MX6 SoloX (Device Tree)
[ 1430.811324] Workqueue: events disconnect_work [cfg80211]
[ 1430.817785]  unwind_backtrace from show_stack+0x10/0x14
[ 1430.823062]  show_stack from dump_stack_lvl+0x58/0x70
[ 1430.828150]  dump_stack_lvl from __warn+0x70/0x1c0
[ 1430.832986]  __warn from warn_slowpath_fmt+0x16c/0x294
[ 1430.838167]  warn_slowpath_fmt from 
is_wiphy_all_set_reg_flag+0xb4/0x144 [cfg80211]
[ 1430.846957]  is_wiphy_all_set_reg_flag [cfg80211] from 
regulatory_hint_disconnect+0xc/0xdc [cfg80211]
[ 1430.858313]  regulatory_hint_disconnect [cfg80211] from 
disconnect_work+0x130/0x144 [cfg80211]
[ 1430.869050]  disconnect_work [cfg80211] from 
process_one_work+0x204/0x620
[ 1430.876943]  process_one_work from worker_thread+0x1b0/0x474
[ 1430.882642]  worker_thread from kthread+0x10c/0x12c
[ 1430.887554]  kthread from ret_from_fork+0x14/0x24
[ 1430.892290] Exception stack(0xf0855fb0 to 0xf0855ff8)
[ 1430.897364] 5fa0:                                     00000000 
00000000 00000000 00000000
[ 1430.905561] 5fc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[ 1430.913760] 5fe0: 00000000 00000000 00000000 00000000 00000013 
00000000
[ 1430.921569] irq event stamp: 1985873
[ 1430.927055] hardirqs last  enabled at (1985911): [<c019e8e0>] 
console_unlock+0x134/0x164
[ 1430.938018] hardirqs last disabled at (1985920): [<c019e8cc>] 
console_unlock+0x120/0x164
[ 1430.949023] softirqs last  enabled at (1985908): [<c012f3b4>] 
handle_softirqs+0x2ac/0x49c
[ 1430.959991] softirqs last disabled at (1985881): [<c012f74c>] 
__irq_exit_rcu+0x154/0x194
[ 1430.970888] ---[ end trace 0000000000000000 ]---
[ 1431.012846] ------------[ cut here ]------------
[ 1431.019064] WARNING: CPU: 0 PID: 9 at net/wireless/core.h:239 
is_wiphy_all_set_reg_flag+0x134/0x144 [cfg80211]
[ 1431.031956] Modules linked in: rtw88_8822cu rtw88_8822c rtw88_usb 
rtw88_core mac80211 libarc4 cfg80211 btusb btrtl btintel btbcm btmtk 
imx_sdma ip_tables x_tables
[ 1431.049154] CPU: 0 PID: 9 Comm: kworker/0:1 Tainted: G        W       
    6.6.51-00141-ga1649b6f8ed6 #7
[ 1431.061186] Hardware name: Freescale i.MX6 SoloX (Device Tree)
[ 1431.067039] Workqueue: events disconnect_work [cfg80211]
[ 1431.073498]  unwind_backtrace from show_stack+0x10/0x14
[ 1431.078776]  show_stack from dump_stack_lvl+0x58/0x70
[ 1431.083865]  dump_stack_lvl from __warn+0x70/0x1c0
[ 1431.088701]  __warn from warn_slowpath_fmt+0x16c/0x294
[ 1431.093883]  warn_slowpath_fmt from 
is_wiphy_all_set_reg_flag+0x134/0x144 [cfg80211]
[ 1431.102757]  is_wiphy_all_set_reg_flag [cfg80211] from 
regulatory_hint_disconnect+0xc/0xdc [cfg80211]
[ 1431.114098]  regulatory_hint_disconnect [cfg80211] from 
disconnect_work+0x130/0x144 [cfg80211]
[ 1431.124831]  disconnect_work [cfg80211] from 
process_one_work+0x204/0x620
[ 1431.132724]  process_one_work from worker_thread+0x1b0/0x474
[ 1431.138423]  worker_thread from kthread+0x10c/0x12c
[ 1431.143335]  kthread from ret_from_fork+0x14/0x24
[ 1431.148070] Exception stack(0xf0855fb0 to 0xf0855ff8)
[ 1431.153144] 5fa0:                                     00000000 
00000000 00000000 00000000
[ 1431.161341] 5fc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[ 1431.169539] 5fe0: 00000000 00000000 00000000 00000000 00000013 
00000000
[ 1431.176768] irq event stamp: 1986265
[ 1431.182674] hardirqs last  enabled at (1986275): [<c019e8e0>] 
console_unlock+0x134/0x164
[ 1431.193819] hardirqs last disabled at (1986284): [<c019e8cc>] 
console_unlock+0x120/0x164
[ 1431.205066] softirqs last  enabled at (1986314): [<c012f3b4>] 
handle_softirqs+0x2ac/0x49c
[ 1431.215769] softirqs last disabled at (1986293): [<c012f74c>] 
__irq_exit_rcu+0x154/0x194
[ 1431.226678] ---[ end trace 0000000000000000 ]---

```

