Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1EC78C19
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2019 14:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfG2M6R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jul 2019 08:58:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:38030 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727336AbfG2M6R (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jul 2019 08:58:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CBCADAF39;
        Mon, 29 Jul 2019 12:58:15 +0000 (UTC)
Message-ID: <1564405088.25582.13.camel@suse.com>
Subject: KASAN reporting bug in ath6kl
From:   Oliver Neukum <oneukum@suse.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org
Date:   Mon, 29 Jul 2019 14:58:08 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I am looking at this report:

Title:              general protection fault in
ath6kl_usb_alloc_urb_from_pipe
Last occurred:      0 days ago
Reported:           102 days ago
Branches:           Mainline (with usb-fuzzer patches)
Dashboard link:     https://syzkaller.appspot.com/bug?id=cd8b9cfe50a0bf
36ee19eda2d7e2e06843dfbeaf
Original thread:    https://lkml.kernel.org/lkml/0000000000008e82510586
5615e3@google.com/T/#u

This bug has a C reproducer.

No one replied to the original thread for this bug.

This looks like a bug in a net/wireless USB driver.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+ead4037ec793e025e66f@syzkaller.appspotmail.com

--

It looks like a bug in
static int ath6kl_usb_setup_pipe_resources(struct ath6kl_usb *ar_usb)
to me, which happily does nothing if the device has no endpoints.
THis needs sanity checking, but it looks like the driver
really uses 8 endpoints. Can you confirm that all 8 of them
are indeed needed?

	Regards
		Oliver

