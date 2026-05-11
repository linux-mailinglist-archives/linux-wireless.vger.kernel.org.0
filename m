Return-Path: <linux-wireless+bounces-36194-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iXrMCyB8AWoNbAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36194-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 08:50:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B35B508B22
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 08:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 892B63007F43
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 06:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CE629B78D;
	Mon, 11 May 2026 06:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzMyQ2lg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4BC23D297
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 06:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482204; cv=none; b=W8JKo+etckvPtr4PNviWJd099r1ulAkGpMXmXBBz4woYPzHoOLHr5MhMDBII+8y5NMeVA24tj4J8SYSHYzG9AFvK2Tq69/jHTAreh/samzM4/nfGLq/Mvsd0BG7s2LMsuUYmteMyb899ENh0nU/jGTrkSuQJIvAQTwtbT47lyqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482204; c=relaxed/simple;
	bh=rgS/0l6r2CgyudD+u+EvkAtQoUpwjeko15fROUxvKd8=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UHngGDBfR2fCt/zrqsjI3Mt6vaFv4E0v0gqFViR1YlwyGszCObnH3tT/YjfDTQbDKsBThOc6VDTZgNs7zQFbQn688ZRPgZqTadwAr7DoUNJXaTY41nQ0B4/WU+C3w8W6JB/eN9oRrtJOe69g896vs+W/xoXjfnAM05epQsSGYwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qzMyQ2lg; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-367c26471f5so1249903a91.1
        for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 23:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778482203; x=1779087003; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oNhcV8fYTYWBpf77/lpbdyHWSTyaRCQz1rcI58G5iCs=;
        b=qzMyQ2lgoFqs9BNVodIstRZPevJTHtGoccDwjWTosimqNUk6DzaTFQj92h0OuIvakT
         W/a/QzL2+ZLvRsxT1WwfRoAMtkv+atEUyEpksFsc6mxOk9aKsOK6lbcN2ksd6n3w76z9
         Ghhgly8UpD3RA2iOEvytAM0Q8T9pOV+RQqNvigf19brwxad5S6G8BghWXGQF8Z3QBpG7
         +n0quVQ9zxCYnA6Xd6L2+vnygKzFAnNKSBJuVUh1fBgwZaGAooa45ZYBYe6x3FfGfzPQ
         IfvuaSjA1xmd28QIG1lAj7QPtyhRGt+jO7IDFIg0JWl9fTPSd658LaWYWGTzYkC+ZAIM
         LrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778482203; x=1779087003;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oNhcV8fYTYWBpf77/lpbdyHWSTyaRCQz1rcI58G5iCs=;
        b=ILMA1Bj6vjSq+ZieX9cXhZj4E5rqJNP/xFSRFeCC7Z7zTUvERwoM61gPYbAq/Bqik4
         a5YUlQQT8Qtx8t2h0+XsFd9Ub9bpgI/MTYLo/ZUAYqRqVczhbS0M3v4uPD7Fkwd5BPjE
         ZUEQxbWm6hxPmbytTrw24YQFxwEvs5JCNLtoL/COtCYtUSmxuJFDnqxsw+lxAhC13zW1
         BL3Mpm3hHn+Sd8U4bosviy0vqfGBaDgOi6sGvMyJze6icZa60ryOFfbWBIx7H4TgyBfC
         lXrTmq0uN12pFT67tTuB2xBIMojmV09S8lJuhJycueZNqNYbWmD7xAfHGSaGEiz6sWYY
         5ipQ==
X-Gm-Message-State: AOJu0YxkiGTNP9/N5MjyK2xoFQWHAXuVIyZbdClaW2PHq2IvS9MydkGv
	+/VzgA3Omzeg0eTjLnL+SSAmJ56+N6PbEmUOc9Rnc6wnvQ4vkONhuritocScHntIsVs=
X-Gm-Gg: Acq92OEMPq8k2hv4mKK6TQ63JIBprwyDQQbt4XCYbVZDU3ZikQ4lgo1TYzTOc7bTbNp
	XfcL1rrNI9pZkmvEfvqNDkbuztYVH6py29Cjy0WNlkJ4MSaAjCa9fbva1VLV7+AfCHJbk15G3Od
	4PMauUph5TJmmEru7BmmY6NZYIdUqr/4iljloBJZuKU8T80rIY2JzUYjSnAseKA29ZKrftICmTs
	7T9haHYyT3OR/xPyqTE2CQSf7a28No1xXI7xdtNi3tgJowuBKl7tAXTj8ZYxetr77y9yanryChE
	vcOoCab7RjbehhwzMtaX5qUPF1UcagHYOdyPKJS9JuhyK9twkBP7pxiJq76F39png4n0WQ7KnZ/
	TU3sHprB3q+3ug94akzYnLZhPna5BhtV5x4gKPZ3/C5RJ3ua97wyvhx+hci4YM1Z57MJHs0OygL
	KHqeU=
X-Received: by 2002:a17:90a:16cf:b0:365:fd4b:24f5 with SMTP id 98e67ed59e1d1-365fd5a6b04mr11240155a91.8.1778482202342;
        Sun, 10 May 2026 23:50:02 -0700 (PDT)
Received: from localhost ([2a09:bac5:4300:dc::16:1d2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d629f40bsm6517538a91.7.2026.05.10.23.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 23:50:01 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Mon, 11 May 2026 14:49:46 +0800
To: linux-wireless@vger.kernel.org, 
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: iwlwifi: network not back after resuming from suspend since v6.15-rc2
Message-ID: <agFzc-Ngf_ZFXJ3o@Rk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-Rspamd-Queue-Id: 7B35B508B22
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36194-lists,linux-wireless=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coibyxu@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gitlab.com:url,fedoraproject.org:url]
X-Rspamd-Action: no action

Hi Emmanuel,

I notice since v6.15-rc2, most of the times the network won't be back
again after resuming from suspend. And sometimes I need to run
"systemctl suspend" for 8 or 9 consecutive times to make WIFI available
again. bisect and manual reverting show 15220a257319 ("wifi: iwlwifi:
don't warn if the NIC is gone in resume") is the 1st bad commit. 

Here are some other clues that may help resolve this issue,

     1. An iwlwifi setting [1] can make this issue disappear,
        options iwlwifi swcrypto=0
        options iwlwifi bt_coex_active=0
        options iwlwifi power_save=0
        options iwlwifi uapsd_disable=1
        options iwlmvm power_scheme=1

     2. Before v6.15-rc2, the issue rarely happens. And if it happens,
        simply suspending once can bring the network online again. Other
        users seem to have experienced the same issue e.g. [2][3][4].

     3. Suspending by "rtcwake -m mem -s 5" instead of by "systemcl suspend"
        can make it much easier to reproduce this issue for kernels older
        than v6.15-rc2.

If you need more details from me, feel free to let me know! And I'll
very happy to test any possible solutions. Thanks!

## Notes on bisect

The bisect is done with an experimental branch [5] of
kernel-auto-bisect tool [6].

1. bisect conf file
    TEST_STRATEGY="simple"
    RUNS_PER_COMMIT=6
    RUNS_PER_GOOD_COMMIT=3
    GOOD_COMMIT=6.14.4-300.fc42.x86_64
    BAD_COMMIT=6.19.14-200.fc43.x86_64
    REPRODUCER_SCRIPT=reproducer_wifi.sh

2. Reproducer 
    on_test() {
            # If sleep only 5 or 10 s, somehow the system will get suspended forever i.e.
            # "rtcwake -m on won't wake up the system .
            sleep 15
            ip --brief addr show wlp4s0 
            # "rtcwake -m mem -s 5" will quite often makes wifi unavailable. So use
            # systemctl suspend instead
            #rtcwake -m mem -s 5
            # Wake up the system after 4s
            rtcwake -m on -s 4 &
            systemctl suspend
            sleep 12
            ip --brief addr show wlp4s0 | grep -q " UP "
    }

kernel-auto-bisect went through a two-phase bisection,
     1. find 6.14.6-300.fc42.x86_64 as the 1st bad build
     2. find Fedora kernel commit 6453e892cf86c [7] as 1st bad commit

I can't bisect against upstream kernel directly because v6.15-rc2 won't
be able to mount my root partition. So I manually reverted upstream
15220a257319 ("wifi: iwlwifi: don't warn if the NIC is gone in resume")
in v6.15 to confirm it's indeed the bad commit.

[1] https://bbs.archlinux.org/viewtopic.php?pid=2227202#p2227202
[2] https://bbs.archlinux.org/viewtopic.php?id=301971
[3] https://discussion.fedoraproject.org/t/random-wi-fi-adapter-loss-on-fedora-42-intel-alder-lake-p-cnvi/152878
[4] https://forums.opensuse.org/t/wifi-suddenly-no-more-available/184399
[5] https://github.com/coiby/kernel-auto-bisect/tree/random_issue_bisect
[6] https://github.com/rhkdump/kernel-auto-bisect
[7] https://gitlab.com/cki-project/kernel-ark/-/commit/6453e892cf86c900d51f5884e9013e0dbeeea4ad


-- 
Best regards,
Coiby

