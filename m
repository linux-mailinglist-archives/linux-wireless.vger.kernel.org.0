Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389CD30AB62
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Feb 2021 16:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhBAPbk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Feb 2021 10:31:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24340 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231805AbhBAPb3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Feb 2021 10:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612193403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Xl3Z2KbuvokwHYdjdHn+S0bwXUyXZmnEWUWjpITVM3U=;
        b=dvKT/4aBwBrLjzhaA+Kj4v1AuP9VL/xw30lz/uOOINxppo64BM4wOOFA63Bgby7plN/Aw8
        ZvrltUvXeMbhzEOYz77MKVBdq/pdTQSupP8z2mVxTS6+/gtJkwV0ey9rAuQ6pEYFKeEjF3
        fPnZcL90nWdaH0VUomrwHmuoxzMlT6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-vy0U_A2TPyC8rOpzuKC1LA-1; Mon, 01 Feb 2021 10:30:00 -0500
X-MC-Unique: vy0U_A2TPyC8rOpzuKC1LA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1235A19611AE;
        Mon,  1 Feb 2021 15:29:59 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-234.ams2.redhat.com [10.36.112.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0A025C1A1;
        Mon,  1 Feb 2021 15:29:57 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Berg <johannes.berg@intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Ross Schmidt <ross.schm.dev@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH 5.11 regression fix 0/1] staging: rtl8723bs: Move wiphy setup to after reading the regulatory settings from the chip
Date:   Mon,  1 Feb 2021 16:29:55 +0100
Message-Id: <20210201152956.370186-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Greg, Johan,

Unfortunately the deadlock fix for the rtl8723bs staging driver,
which Johan wrote and landed for 5.11-rc6, is not enough to avoid
the rtl8723bs driver from regressing in 5.11 .

Since the original fix has my Tested-by: I double checked and it
does fix things on some devices with a rtl8723bs wifi chip but not
on others. See the commit-msg of my follow-up fix details.

I've written a small follow-up fix, it would be nice if one of
you can get this to Linus for 5.11. But I understand this is cutting
it pretty close to the release, so if it misses 5.11 then this can
be picked up by the linux-stable releases.

Regards,

Hans


Hans de Goede (1):
  staging: rtl8723bs: Move wiphy setup to after reading the regulatory
    settings from the chip

 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.29.2

