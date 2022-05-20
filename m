Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C88052EADA
	for <lists+linux-wireless@lfdr.de>; Fri, 20 May 2022 13:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348182AbiETLcx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 May 2022 07:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243617AbiETLcs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 May 2022 07:32:48 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021BE57B0A
        for <linux-wireless@vger.kernel.org>; Fri, 20 May 2022 04:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=RopgROlQ7ybJqnp4i0rYvL2bBOZOqUxuvK+WwOOlKWU=; t=1653046367; x=1654255967; 
        b=G4b8erAZqsj/zBeOZRQSABBbQv+EyMwTW/ark1ARU1ddEm6LXW2p3TbocMGg4ViCimgWNh0WDRj
        Iml1OxrZ+by0ZGCHxKBKxZyqJBHRxHj5DGUWoTOuGnjCmMA7sRBhD1Q1cD3ARsowyjPSyb4Mqak9b
        Bc9BpkhCEBglUYQNvVp6HlibKF2fKXUkYBreOWTFWqtxolMPk2S5Fnlcp7XbVDxvbzKAKhrit3xtS
        vO9Y4vVvSWfDtKPY2FVthbB+lVduKaa5S5uOcxRgJcRlRbK7Jg/N9w9p96bSn4Q3aHnkT0VwpKHEs
        Wg91mI5Leg58nEPJPbMUZXL3WHicSnb9/mNA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ns0s8-00HJjx-Gc
        for linux-wireless@vger.kernel.org;
        Fri, 20 May 2022 13:32:44 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 0/4] initial interface-related MLO work
Date:   Fri, 20 May 2022 13:32:38 +0200
Message-Id: <20220520113242.129546-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

(Note the dependency on these three patches:
https://lore.kernel.org/linux-wireless/20220519232721.af7f735316fb.I77ae111a28f7c0e9fd1ebcee7f39dbec5c606770@changeid/)

This series contains initial refactoring of data structures in both
cfg80211 and mac80211 for MLO support. This is likely not complete,
but it serves to illustrate the future layout of data structures in
the stack with MLO support.

This also doesn't enable anything yet - you cannot use the link ID
attribute yet since you cannot use the new ADD_LINK command, it's
gated by a wiphy flag that isn't set.

However, this is a stepping stone - from here, we can even consider
splitting up work, e.g. separately focus on AP mode, clients with
AUTH/ASSOC, and clients with CONNECT (i.e. not mac80211).

The next things with this would be:
 1) Look at the auth/assoc APIs, at present I'm not even
    certain where we do what, I guess userspace would pick
    the BSS entries and send them in the LINKS attribute,
    per link, or so, and mac80211 builds the multi-link
    element(s) as appropriate?

 2) Look at interface combinations advertisement and tie it
    into this patch where appropriate; Vasanth is looking
    at this.

 3) Try to get to a point where we can at least start the
    beaconing process, i.e. look at mac80211 much more and
    refactor data structures there.

I'll probably start with (3) since at least beaconing lets
me then test at least scanning for (1) and perhaps sending
the association request etc.

I'm aware that this leaves a number of FIXME comments in cfg80211,
we'll have to fill those in as we port features to MLD one by one.

We'll also have to properly implement the REMOVE_LINK command and
various other bits here and there, but I think with these patches
we can start working in different areas independently.

johannes



