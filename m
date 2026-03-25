Return-Path: <linux-wireless+bounces-33870-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NzGOUBIxGn5xwQAu9opvQ
	(envelope-from <linux-wireless+bounces-33870-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 21:40:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 794C832BEB6
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 21:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA2CF306709A
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 20:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0165737419C;
	Wed, 25 Mar 2026 20:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/U0JU5q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9D8374E42
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 20:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774471157; cv=pass; b=T7IvOXzr5YlKu0VG+9nhyJ3IOXY29SlrtM8A1NPSGVPDTJEKexISvZkpKt8IIBxqIYLbjBSCCWWzXco1Cu7WTcItJj1XjrxaVs6uc4slC1NFJHvvtHEmPg1BR5JZIig6S1wv/rHEWb7clIzzsikcvF9wMQQnRZXvEbjWQwe/yHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774471157; c=relaxed/simple;
	bh=HM/jJrqCmqzGUG6pmdeRoD5OXQbvZljnStVz6rg4ctE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nNfQ2rPn/CUYYBtGzLFw6eLzekvIRdB5YCjOYlKnYRkmdZdcG+0CRXNaKfmc9vtPIA0JqKjIcSOgsfnEm0uFh8dHD0qNVp9AGLFAJJVItrGMc5ZExXYIi7OBuWY7MvOLfp+u/I7LwZktpaSwouvFxP6zbCwHXM4kQkDxPYA1F/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/U0JU5q; arc=pass smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4670676ba03so96661b6e.1
        for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 13:39:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774471154; cv=none;
        d=google.com; s=arc-20240605;
        b=j8vp7dxfu07wIQqMHU9F2EVxI4Iq+WRGrZu4n5UEsyFXedkiphHW6lWkD45ucjIwB8
         rcDYPROZfKRruapBCLtWlxM93ccjlsE/k/ppsixCcANAX00aw94oaPKnFtWXCQCWZlRx
         cQl4l1Wi1dv1n587yQ950VYFM8fH5VkLkEhD0DIOOR7fJzSsBBCxRT7hRDR6XziftIga
         cMHSWCSP92dTEKJudYq01yh+5bfVHtH2qqRObLYxf8VqRdwBY+ylk9AJaAjhuR8RgziU
         kXVykSPlGEWyhxEPeXNURixyCAMfw5fNSTOFbMqtoQNePkySd94LJvuZ3E4EL0Wk6WEG
         lqAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RF8aPhfziFk8x+sXRrf03PU/KEmgbfrrwPszOKkA3Vs=;
        fh=fFUQ3bDSnwWYL/1dqZwPKYywXd5TONRsAevI/mvHYbI=;
        b=QoUD4QgIstrZsZFpA3RYAyTix3u4SAq3yh5z8OioX180AiXXCyKtgJ3R0gzXX6f/BZ
         ijUPpTwq8COo9CGC0eLDbR0KAakzxRx0SDS658KqI1YNcnpmnIOm4bmT/V1FM5Zdv9/F
         PvQ+Bsy+GRITaG5r1AEZC78/R2d4jlX9wW8zqvoB8/dDFU4R+LcdNPDk9+mPR4YywaAR
         Fjqc9gCyqeq4k4bSMrkYHekhebOZCFuHfxTe3FC4EWM47WTUsmgXOV/h0uBxW49T9J24
         SX2vwb0UWbRowh1hBNUsnPaqLMSR7NidV+JX+oZEDlYmjOlNIfIzZt5A/46QU3I/5Jog
         GOvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774471154; x=1775075954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RF8aPhfziFk8x+sXRrf03PU/KEmgbfrrwPszOKkA3Vs=;
        b=M/U0JU5qsqs/cI19sH+yeaL2rZRNTgk1Y0/l96If84xKl0hSP13N8iVtblm7BX48iv
         gjCXpI/wq3xST6wPm3xQZ6TVSeUN2AsJJOzzx5KdTdCj1Yrnw5TcUc1KItBtXvfWMaCC
         W+7Kt+AeuN7qsDv3LRqooVY2QuZurs8NS5rCAVLmQFhky3SBwQ3QYWh2otirCV9Ow9Lt
         gh2C5Nwa6a9DOn4z3CtkSH6y61QGEZwPPkERZjFMtVBRMNnIhyYnqAi3yd9KQz9YenB4
         dV5Cdd4SaKCCcqnXaBCHbPAuXLj+uAm11Am1PCPuQIZ1d5hazpGy9HGFX9TZGMzWB++A
         3FhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774471154; x=1775075954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RF8aPhfziFk8x+sXRrf03PU/KEmgbfrrwPszOKkA3Vs=;
        b=AAoNKZL998B8H5E3o/WWMCOO1koiy7IFPU58wQb4/KDL1uwfdIzwc9b3QE7Kp64oWh
         2FjE+BzIa9A5AXycSkDETsPwnc7Kxc/Eq9tsjqqPXPBO4MxeRB+3wMQtNDRVGYg/dxwM
         2sIZFAfqRMFs8ruXih7A8iNvFSygJpcIVNx4Yc7fY+OPgAQjcVc2L9aaXp9Kno37aFvk
         jSe/7T+hS/PgNyGXKNrNRTXVtuph2WFnVgXTfZJJL6moUH8eDVDh31MDuQ2t0bYIuo88
         ADO2udcsBhY0L2uH2CKTtBxvt6J6HLbZYTe/FMUj6kfAjDTKli2QqQVdRVFtFPJS5v+U
         LbjA==
X-Gm-Message-State: AOJu0YzDowA9IbXJjZCgsKrCIJsYrl7eTpaUpvNzZiBJUJmLSniygCf9
	iPNSUDfxVkReqpKA8AiJxW8jlxn9i1u/6mJgnD517DPV5n+nCW+cEPb99BljFsICQqp5AcskoJ+
	EkHMndASlStwFltLaRKTXyFK7ZFoxo+CEQkP5v7q1lg+r
X-Gm-Gg: ATEYQzzXCn0jSxphsq9p7DUJOgrShOkA2kDRdMJ2n5SNOstoJdfybJ2640xqODORSEO
	aSaJk3a3eiquZLxfAmQa89XAts46rq0iQYkHC4bHmL41QlRcHH9PS+TEYyI0ZhRtls1Zv9nTeyZ
	jrH6cZZ9J5YWecpCpGLgix7On0nIt2k63d4iwMc0BQZcfI3d6YZ+2NFHLFB/EksSKdQk0r8fKxi
	qMk19Pq7w25nqGnMc5oDH7ho96uep8F8kzonGwLArloM/7U6hQq5ErGeSRk6+veT96eRu9YBpO8
	mdYxaLOx
X-Received: by 2002:a05:6808:1186:b0:467:21dd:aa94 with SMTP id
 5614622812f47-46a5c7e111fmr2221404b6e.55.1774471153893; Wed, 25 Mar 2026
 13:39:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <1e96af437fa24674b353ddb530b2d8e7@realtek.com> <CALdGYqQb=Vt0jjqW7k8RGMV1gczL0cg-26cHgCm3MmzBjezGMQ@mail.gmail.com>
 <792645eed36041f0b3df951f1b28a08a@realtek.com> <e6720993c8c14245981432cfa4ae902b@realtek.com>
 <CALdGYqQn8GGXXjZTsL+a5Mfdmw5HRYB2Jyvqq5M5SUwxK9yd_g@mail.gmail.com>
 <CALdGYqQee1sjgdBAPJSyb1gL6ksK4z8Uw_v3ANTnyXE+LXFAiA@mail.gmail.com>
 <458ed80e39734ea99610050140bb31ce@realtek.com> <CALdGYqQykO9ZzO=-+D17R_8LC=Win5nGN6-9zFqChtNEyUzEfg@mail.gmail.com>
 <CALdGYqTHz5Pz3uSGLbrVuNMWAXaqniUCuOSQACXUYHSL22ySvw@mail.gmail.com>
 <CALdGYqQ5K0iuxjjX4TwNLi9Km5O+YL3Y9r6Bwfk9BaiuV3BHPA@mail.gmail.com>
 <CALdGYqRYVxGbg+qRNUvRNr9V4f2YVZ7p=amwq1ktdmZVkwxjQg@mail.gmail.com>
 <CALdGYqSq416qqqZ7t+wG5fir9NWfi3578+brdaj05q-42Gj14w@mail.gmail.com>
 <CALdGYqSf66mBiufysr3tjm74A_w98LRN50fik0U9WGVvkBJ_5g@mail.gmail.com>
 <1bd495ffe57c47eb827eec084729afa2@realtek.com> <CALdGYqSMUPnPfW-_q1RgYr0_SjoXUejAaJJr-o+jpwCk1S7ndQ@mail.gmail.com>
 <e5f00d0a42994812b42df867718fa087@realtek.com> <CALdGYqRbkV7_w7WDiqD-vYMa8MUFV7nSYz-=q2FzotgLHRy=HA@mail.gmail.com>
 <cb32c1eefb614a8bb96ef6fe2c4f4989@realtek.com> <CALdGYqQ3tS_aQpmf7xLkaCG9W55ATQXP=tnRNdjBAG8waqg8yA@mail.gmail.com>
 <dbe78a09fafe4a0ab16cd691049896a8@realtek.com> <CALdGYqQ3JQgFvvjiqh-ck8UqUQpAoJ0zeUzEL4i4Un8qPmqxJA@mail.gmail.com>
 <CALdGYqQuS5EOWCaeimr6PY758feF-DPo5i3XFwoQ8ewf4xnm7A@mail.gmail.com>
 <b231d63665334ac786e808610fe4a1e9@realtek.com> <CALdGYqSd61wxNrPDui+m-S+Na_is-RM18-=L6xm-Jf4QQ+-DOg@mail.gmail.com>
 <a8e187e1b40e4a35bbeb3bc3a3d21821@realtek.com> <CALdGYqRPcDRctCpNSJFatXvqMKLFiiRGXZoQa3KJwfwutHJEwA@mail.gmail.com>
 <ba9790526e4e42c386642a05fcbc2f34@realtek.com>
In-Reply-To: <ba9790526e4e42c386642a05fcbc2f34@realtek.com>
From: LB F <goainwo@gmail.com>
Date: Wed, 25 Mar 2026 22:38:36 +0200
X-Gm-Features: AQROBzDv2a92I41pzvVHxuPJElLXiM0XBV9RG-ynTJMuVM9iD-uRrzMgLcZ4L0M
Message-ID: <CALdGYqQ5U2USCqVEixoDda1Xd2ugBakh1K1QkaKAU7HPSTTNWg@mail.gmail.com>
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33870-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,archlinux.org:url]
X-Rspamd-Queue-Id: 794C832BEB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Subject: Cross-platform analysis: RTL8821CE ASPM/LPS instability
        affects multiple OEM platforms beyond HP P3S95EA#ACB

Hi Ping-Ke,

First of all, thank you very much for your work on the rtw88 driver
and for the time you spent helping us resolve the issues on our HP
laptop. Both patches -- the v2 DMI quirk (ASPM + LPS Deep) and the
v2 RX rate validation (rx.c) -- have been tested and verified stable
on our system across two kernel updates (6.19.9-1 and 6.19.9-2),
sustained network load (~1.9 GB), and multiple suspend/resume cycles.
The system is now completely free of freezes, h2c errors, and
mac80211 warnings. Your patches genuinely solved every issue we had.

While working through this, I noticed that many other users across
different hardware platforms appear to be experiencing the same
problems that your patches resolved for us. I decided to collect
and organize these observations in case they might be useful to you.

Please note that this is an amateur analysis, not a professional
one -- I am just a user trying to help. It is entirely possible
that I have missed nuances or made incorrect assumptions. My only
goal is to share what I found, in case it provides useful data
points or sparks ideas for broader improvements. If any of this
is not relevant or not useful, please feel free to disregard it.


1. KERNEL BUGZILLA: OPEN RTL8821CE REPORTS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I reviewed all open RTL8821CE bugs in kernel.org Bugzilla. Three
of the six show symptoms that directly match the root causes
addressed by your patches (ASPM deadlock and LPS Deep h2c failures).

--- Directly correlated with ASPM/LPS patches ---

Bug 215131 - System freeze (ASPM L1 deadlock)
  Title:    "Realtek 8821CE makes the system freeze after 9e2fd29864c5
             (rtw88: add napi support)"
  Reporter: Kai-Heng Feng (Canonical)
  Kernel:   5.15+
  Symptoms: Hard freeze preceded by "pci bus timeout, check dma status"
            warnings. RX tag mismatch in rtw_pci_dma_check().
  Workaround confirmed by reporter: rtw88_pci.disable_aspm=3D1
  Reporter note: "disable_aspm=3D1 is not a viable workaround because
                  it increases power consumption significantly"
  Status:   OPEN since 2021-11-24.
  Link:     https://bugzilla.kernel.org/show_bug.cgi?id=3D215131
  Relevance: Identical root cause to Bug 221195. The reporter's
             confirmed workaround (disable_aspm=3D1) is exactly what
             the DMI quirk implements.

Bug 219830 - h2c/LPS failures + BT crackling
  Title:    "rtw88_8821ce (RTL8821CE) slow performance and error
             messages in dmesg"
  Reporter: Bmax Y14 laptop, Fedora 41, kernel 6.13.5
  Symptoms: - "failed to send h2c command" (periodic)
            - "firmware failed to leave lps state" (periodic)
            - Lower signal strength vs Windows
            - Bluetooth crackling during audio playback
  Cross-ref: https://github.com/lwfinger/rtw88/issues/306
  Status:   OPEN since 2025-03-02.
  Link:     https://bugzilla.kernel.org/show_bug.cgi?id=3D219830
  Relevance: The h2c/lps errors are the same messages we observed
             before the DMI quirk disabled LPS Deep Mode. The BT
             crackling may correlate with the invalid RX rate
             condition addressed by your rx.c validation patch.

Bug 218697 - TX queue flush timeout during scan
  Title:    "rtw88_8821ce timed out to flush queue 2"
  Reporter: Arch Linux, kernel 6.8.4 / 6.8.5
  Symptoms: - "timed out to flush queue 2" every ~30 seconds
            - "failed to get tx report from firmware"
            - Stack trace: ieee80211_scan_work -> rtw_ops_flush ->
              rtw_mac_flush_queues timeout
  Status:   OPEN since 2024-04-08.
  Link:     https://bugzilla.kernel.org/show_bug.cgi?id=3D218697
  Relevance: The flush timeout occurs when the firmware cannot
             respond to TX queue operations -- consistent with
             firmware being stuck in LPS Deep during scan.

--- Potentially related (no confirmed workaround data) ---

Bug 217491 - "timed out to flush queue 1" regression (kernel 6.3)
  Manjaro user. Floods of "timed out to flush queue 1/2".
  Similar pattern to Bug 218697.
  Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217491

Bug 217781 - Random sudden dropouts
  Arch user. Random disconnections during streaming/transfers.
  Reproduced on Ubuntu and Fedora (kernels 5.15 to 6.4).
  Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217781

Bug 216685 - Low wireless speed
  Reduced throughput vs expected 802.11ac performance.
  Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216685


2. SYMPTOM-TO-PATCH MAPPING
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

dmesg signature                    Patch that resolves it
--------------------------         ----------------------
Hard system freeze                 pci.c DMI quirk (disable ASPM)
"pci bus timeout, check dma"       pci.c DMI quirk (disable ASPM)
"firmware failed to leave lps"     pci.c DMI quirk (disable LPS Deep)
"failed to send h2c command"       pci.c DMI quirk (disable LPS Deep)
"timed out to flush queue N"       pci.c DMI quirk (disable LPS Deep) [1]
"failed to get tx report"          pci.c DMI quirk (disable LPS Deep) [1]
VHT NSS=3D0 mac80211 WARNING        rx.c rate validation (v2)

Confirmed in bugs: 215131, 219830, 218697, 221195.
[1] Inferred: flush timeout occurs when firmware cannot exit LPS
    to process TX queue operations.


3. AFFECTED HARDWARE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Current DMI quirk coverage: HP P3S95EA#ACB only.

Platforms confirmed affected in Bugzilla:
  Bug 221195: HP Notebook 81F0 (P3S95EA#ACB)
  Bug 215131: unknown (Canonical upstream testing)
  Bug 219830: Bmax Y14
  Bug 218697: unknown (Arch Linux user)

Platforms reported in community forums as requiring
disable_aspm=3DY and/or disable_lps_deep=3DY for stable RTL8821CE:
  - HP 17-by4063CL
  - Lenovo IdeaPad S145-15AST, IdeaPad 3, IdeaPad 330S
  - ASUS VivoBook X series
  - Acer Aspire 3/5 series

All use PCI Device ID 10ec:c821 with different Subsystem IDs.


4. LPS_DEEP_MODE_LCLK IN THE rtw88 TREE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I verified in the source which chips have the same
lps_deep_mode_supported flag:

Chip file       lps_deep_mode_supported            PCIe variant
---------       -----------------------            ------------
rtw8821c.c      BIT(LPS_DEEP_MODE_LCLK)            rtw8821ce =E2=9C=93
rtw8822c.c      BIT(LPS_DEEP_MODE_LCLK) | PG       rtw8822ce =E2=9C=93
rtw8822b.c      BIT(LPS_DEEP_MODE_LCLK)            rtw8822be =E2=9C=93
rtw8814a.c      BIT(LPS_DEEP_MODE_LCLK)            rtw8814ae =E2=9C=93
rtw8723d.c      0                                   rtw8723de =E2=9C=97
rtw8703b.c      0                                   (SDIO)     -
rtw8821a.c      0                                   (legacy)   -

Source references:
  rtw8821c.c:2002  rtw8822c.c:5365  rtw8822b.c:2545
  rtw8814a.c:2211  rtw8723d.c:2144

RTL8822CE community reports (Manjaro, Arch forums) confirm the
same disable_aspm=3DY + disable_lps_deep=3DY workaround is effective,
consistent with rtw8822c.c having LCLK enabled.


5. COMMUNITY WORKAROUND REFERENCES
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The following are concrete examples of forums and wikis where the
same modprobe workarounds are actively recommended:

Arch Wiki - RTW88 section:
  https://wiki.archlinux.org/title/Network_configuration/Wireless
  (section "RTW88" and "rtl8821ce" under Troubleshooting/Realtek)
  Recommends rtw88-dkms-git and documents the rtw88_8821ce issues.

Arch Wiki - RTW89 section (same page):
  Documents the identical ASPM pattern for the newer RTW89 driver:
    options rtw89_pci disable_aspm_l1=3Dy disable_aspm_l1ss=3Dy
    options rtw89_core disable_ps_mode=3Dy
  This suggests the ASPM/LPS interaction is a systemic Realtek
  design issue, not specific to rtw88 or the 8821CE chip.

Arch Linux Forum - RTL8821CE thread:
  https://bbs.archlinux.org/viewtopic.php?id=3D273440
  Referenced by the Arch Wiki as the primary rtl8821ce discussion.

lwfinger/rtw88 GitHub:
  https://github.com/lwfinger/rtw88/issues/306
  Directly cross-referenced by Bug 219830. Reporter reports h2c
  errors and investigated antenna hardware (no fault found).

lwfinger/rtw89 GitHub:
  https://github.com/lwfinger/rtw89/issues/275#issuecomment-1784155449
  Same ASPM-disable pattern documented for the newer RTW89 driver
  on HP and Lenovo laptops.


6. OBSERVATIONS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

a) Three open Bugzilla reporters (215131, 219830, 218697) show
   symptoms identical to those resolved by your patches but have
   no upstream fix available since they are not the HP P3S95EA#ACB.

b) Bug 215131 reporter (Kai-Heng Feng, Canonical) explicitly
   confirmed disable_aspm=3D1 as a workaround and called it
   "not viable" due to power cost. A DMI quirk for their
   platform would give them a proper fix.

c) The Arch Wiki documents the same ASPM-disable pattern for
   both RTW88 and RTW89 drivers, suggesting the underlying
   hardware/firmware limitation is shared across generations.

d) Asking Bugzilla reporters to provide their DMI data
   (dmidecode -t 1,2) could allow extending the quirk table
   with minimal effort and zero risk to unaffected platforms.

e) The rx.c rate validation patch is chip-agnostic and requires
   no platform-specific consideration.


7. REFERENCES
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Kernel Bugzilla:
  https://bugzilla.kernel.org/show_bug.cgi?id=3D215131
  https://bugzilla.kernel.org/show_bug.cgi?id=3D219830
  https://bugzilla.kernel.org/show_bug.cgi?id=3D218697
  https://bugzilla.kernel.org/show_bug.cgi?id=3D217491
  https://bugzilla.kernel.org/show_bug.cgi?id=3D217781
  https://bugzilla.kernel.org/show_bug.cgi?id=3D216685

GitHub:
  https://github.com/lwfinger/rtw88/issues/306
  https://github.com/lwfinger/rtw89/issues/275

Arch Wiki:
  https://wiki.archlinux.org/title/Network_configuration/Wireless

Arch Linux Forum:
  https://bbs.archlinux.org/viewtopic.php?id=3D273440

Source code (lps_deep_mode_supported):
  drivers/net/wireless/realtek/rtw88/rtw8821c.c:2002
  drivers/net/wireless/realtek/rtw88/rtw8822c.c:5365
  drivers/net/wireless/realtek/rtw88/rtw8822b.c:2545
  drivers/net/wireless/realtek/rtw88/rtw8814a.c:2211
  drivers/net/wireless/realtek/rtw88/rtw8723d.c:2144


Best regards,
Oleksandr Havrylov <goainwo@gmail.com>

