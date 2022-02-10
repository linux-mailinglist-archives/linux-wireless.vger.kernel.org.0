Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258F54B160C
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 20:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343822AbiBJTQ1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 14:16:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239426AbiBJTQ0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 14:16:26 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957A0101C
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 11:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=0dkc+E9MXfl0wndj4dpVnEQfoRW5D1pyja6mTjwgOfk=; t=1644520587; x=1645730187; 
        b=PtSHLWBMizH0j06cbI8NFLuPpzrjlL4OpHXpBwV7ljeVmJcB3S6t2xyyNFA60qV/lUfRJteDcK1
        I7iNtYfdNjPmm6oMOziJXIHDXKKQs/UMsRIJmcyKQCkdPR/q+Nud9y+maEiJiLYFXNLJ5c4QYUL8N
        IKRWbMTU3NwBGJuGyJFihcsXZDNBP10wiKUPdsxhoPrVrEmgUlS9rKnKdQrDA2epiu7DvEayToX3t
        p9Cf0xT7eZuYFJ3Yf1FNAxvkiDA04fLxCWkBBIzGWSrRmgTjbeqhgiNlpLKUx/kRlxm0lzAyVHyg6
        EIPAIt3uPj3OVTYMouTsVX+HO0enL+p5cYKw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nIEva-00HBut-0X
        for linux-wireless@vger.kernel.org;
        Thu, 10 Feb 2022 20:16:26 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 0/3] HE capability element validation improvement
Date:   Thu, 10 Feb 2022 20:16:20 +0100
Message-Id: <20220210191623.187684-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.34.1
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

Apparently we never really validated this coming from all the
different places, though that doesn't seem to have hurt, but
we usually validate incoming things, do it here too.

johannes


