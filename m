Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACD079BCE0
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Sep 2023 02:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352212AbjIKVsr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Sep 2023 17:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243497AbjIKRPS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Sep 2023 13:15:18 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27EA1A5;
        Mon, 11 Sep 2023 10:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=BBKvXKjeaGA7kn1aOjVgRF8wd8T1PFljhKLxO10gIy8=; t=1694452513; x=1695662113; 
        b=x5C8iKzBd3EsXWrFasHyndcCOeEqe/JOMRx8ucPQ0hWnVOWlroE8ylwtZrbOzHLIEz5FFdLbmrE
        /eHOE/ryxK+laNV9G5f7Fl2IzG3qEQzd+4O7Ch4tvtB21G6y5OUigOMISRXNUjzyc7kB3QMx9G28f
        8gvfa/Tr0xlPayeZciRRY3f9DvCv6psOCRu4a6eV2Z2QSRZMTRgEFHmbmmsAufdHZypcj7ZAEYwMp
        F17Z8Aw/nLXvw9/pAA/BRH8TmXzsDo08A77HTLG5WvYSNOQpRw8Lbo97BKYYe/WrV30C2M243d1NJ
        TmB7V5g6YygultQO9KciwF2rX8PqtSLYpg8Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qfkVC-00Ap5W-1V;
        Mon, 11 Sep 2023 19:15:10 +0200
Message-ID: <c32b6478afb2507ed9247f8b206f5d7c57f46ba4.camel@sipsolutions.net>
Subject: heads-up: wireless/wireless-next merge conflict
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-next@vger.kernel.org, linux-wireless@vger.kernel.org
Date:   Mon, 11 Sep 2023 19:15:09 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

FYI, there's a merge conflict in wireless vs. wireless-next coming.

I've pushed a resolution to wireless-next/merge-2023-09-11 for you to
use if you like, it's non-trivial due to major locking rework in
wireless-next.

johannes
