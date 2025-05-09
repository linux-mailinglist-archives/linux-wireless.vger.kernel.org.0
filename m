Return-Path: <linux-wireless+bounces-22800-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5002BAB1C5D
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 20:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2BDD526593
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 18:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7696E23C51E;
	Fri,  9 May 2025 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVhYlz2o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B60221F2A;
	Fri,  9 May 2025 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746815705; cv=none; b=d6bKAJGXALcVVZ1jyOJBs0qPGw2izm9agHcEA4717/o6BlMEJ/iZ1tiEKOZLB9dhNCeVirahT6NxsnHSeDZhckq4/NxW7w2tpuhLElvfNQsSEumcN62IcTe1alNjBmU7LSKdCGZ7ILErhnPL8iNnX9yyCOhD7/wRXoZz8yCzMg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746815705; c=relaxed/simple;
	bh=49raIuy5WD4Q89Naa/zXtgsLK6Kd3blA2pmtXxYpWPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sid8fwzGqJYFqwege0cJgnyQOb/Iw/duPs8jLN6ynfCzVYCuSBIs0wvJRm3GiiX2a6W76nn4tSa461v60ndM9tsh3/WMoNLgu+ltoXrV2xme6E4iEQOuWSIoonYgnp5OmtyMCveqbaOd/au2VSSuB6Um9sbeM1lqVF1DJZ1mt+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVhYlz2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDB1C4CEE4;
	Fri,  9 May 2025 18:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746815704;
	bh=49raIuy5WD4Q89Naa/zXtgsLK6Kd3blA2pmtXxYpWPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jVhYlz2orEk+8zpU0/L/lHaPmtxA5a8lYzohHDBP9w9ecrAwQxufWUJza7Ms6IRjR
	 sDRHicgAPUqVmsFN4+OKhrKANqyvOVyvhUxVQvz5ql4lytwqmnfZyT48q+VWEMAxCk
	 /koarCRQMfZFCPoZfJVcBjZEq5BpL9DpQKJr4VnQG0FMe8oj3R4o9RhX6lVJttw+yu
	 CWy56Y3ubXPLCsvnkgYLaYO/frHPTRt7k+KSaLd7zM2h6hQPqP4wyBmlsOdlxYNj5F
	 /V1hqQsvQ4V/n+vQBCl3Ju6cpp9Wi9cUlhjF30B5ti3457Kim2MhbHVWOLCDaW9FAm
	 SSxSzMPhnWJrw==
Date: Fri, 9 May 2025 11:35:01 -0700
From: Kees Cook <kees@kernel.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot <syzbot+4bcdddd48bb6f0be0da1@syzkaller.appspotmail.com>,
	johannes@sipsolutions.net, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] UBSAN: array-index-out-of-bounds in
 ieee80211_request_ibss_scan
Message-ID: <202505091124.40FF7F9B1@keescook>
References: <680fd171.050a0220.2b69d1.045e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <680fd171.050a0220.2b69d1.045e.GAE@google.com>

On Mon, Apr 28, 2025 at 12:05:21PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    5bc1018675ec Merge tag 'pci-v6.15-fixes-3' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17ca0374580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=90837c100b88a636
> dashboard link: https://syzkaller.appspot.com/bug?extid=4bcdddd48bb6f0be0da1
> compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a39d74580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=106fa270580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-5bc10186.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3a2f39285e07/vmlinux-5bc10186.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2a37a55f34fb/bzImage-5bc10186.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/cc5918853785/mount_4.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4bcdddd48bb6f0be0da1@syzkaller.appspotmail.com
> 
> wlan1: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
> wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50
> wlan1: Trigger new scan to find an IBSS to join
> ------------[ cut here ]------------
> UBSAN: array-index-out-of-bounds in net/mac80211/scan.c:1208:5
> index 0 is out of range for type 'struct ieee80211_channel *[] __counted_by(n_channels)' (aka 'struct ieee80211_channel *[]')
> CPU: 0 UID: 0 PID: 131 Comm: kworker/u4:5 Not tainted 6.15.0-rc3-syzkaller-00342-g5bc1018675ec #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Workqueue: events_unbound cfg80211_wiphy_work
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  ubsan_epilogue+0xa/0x40 lib/ubsan.c:231
>  __ubsan_handle_out_of_bounds+0xe9/0xf0 lib/ubsan.c:453
>  ieee80211_request_ibss_scan+0x600/0x8b0 net/mac80211/scan.c:1208

This looks like another case of using the array before specifying the
valid entries:

...
                                local->int_scan_req->channels[n_ch] = tmp_ch;
                                n_ch++;
                        }
                }
		...
                local->int_scan_req->n_channels = n_ch;

n_channels controls what array array entries are valid.

-Kees

-- 
Kees Cook

