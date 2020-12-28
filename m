Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350392E6C1A
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Dec 2020 00:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbgL1Wzp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Dec 2020 17:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729385AbgL1ULd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Dec 2020 15:11:33 -0500
Received: from mout3.freenet.de (mout3.freenet.de [IPv6:2001:748:100:40::2:5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89543C0613D6
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 12:10:37 -0800 (PST)
Received: from [195.4.92.126] (helo=sub7.freenet.de)
        by mout3.freenet.de with esmtpa (ID andihartmann@freenet.de) (port 25) (Exim 4.92 #3)
        id 1ktyqe-0001ZB-Vk
        for linux-wireless@vger.kernel.org; Mon, 28 Dec 2020 21:10:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=justmail.de
        ; s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:References:To:From:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GuLy18tWOabIhR7MPJhAkQR8E5CQOISTMjeZlojnZyc=; b=lf+tyenPPPCK3bNHvRKoCKK1y0
        zP7dnVA3gxfGsZF5d6tKWUvsvZjqBiCU7dAGj/NrbAFHEusN9mL9oM1ahBqHDZCz0ZhC+tq3XpGKQ
        8M0FhNYJyBXFXLYoj09V8PMJ+HEayXCvn+0p1GWFZeFj2X3+Z3oEVmusR4U93SJ0+tZ5DtG0hZLAU
        qO/8JbpYAV/xmsl4sXAH+msmNk5b7W1jk8AH+TvvDj9OGjMJXTnD0RwjK80EsYzvVeQOy+hW/JGRC
        weZ1dAasjwT9YXal2biZ/PDoAHfs2wrEoE4BBJJuDzDAuz0HDoO1hq/MeIgWXSzjKpmY7iM260nrj
        bx3X3tRw==;
Received: from p200300de57258500505400fffe15ac42.dip0.t-ipconnect.de ([2003:de:5725:8500:5054:ff:fe15:ac42]:34390 helo=mail.maya.org)
        by sub7.freenet.de with esmtpsa (ID andihartmann@freenet.de) (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (port 465) (Exim 4.92 #3)
        id 1ktyqe-0007Fx-U9
        for linux-wireless@vger.kernel.org; Mon, 28 Dec 2020 21:10:32 +0100
Received: internal info suppressed
Subject: Re: RTL8821CE: CTRL-EVENT-BEACON-LOSS and connection loss
From:   Klaus Mueller <kmueller@justmail.de>
To:     linux-wireless@vger.kernel.org
References: <e0de2157-c06e-c327-e969-d32cb21daf40@justmail.de>
Message-ID: <cf5de66c-de2b-5e55-ed42-476d7e6de50c@justmail.de>
Date:   Mon, 28 Dec 2020 21:10:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <e0de2157-c06e-c327-e969-d32cb21daf40@justmail.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originated-At: 2003:de:5725:8500:5054:ff:fe15:ac42!34390
X-FNSign: v=2 s=6EB6B2AB03BB580A1D961F6F7F088A74D9EB5D2F6C9EC99A30E82308E266EBD1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,



I hoped, that this patch [1] could have fixed the problem - but it
didn't. After doing a scan, there can be seen this error message in
wpa_supplicant.log:



nl80211: send_and_recv->nl_recvmsgs failed: -33



After that, the CTRL-EVENT-BEACON-LOSS have been coming up again and
short time later, the connection has been broken (but could be
reconnected again and disconnected again and so on). Pretty unusable.





Thanks

Klaus



[1] https://marc.info/?l=linux-wireless&m=160914401525592&w=2
