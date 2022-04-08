Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849AF4F9891
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Apr 2022 16:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiDHOvG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Apr 2022 10:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbiDHOvF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Apr 2022 10:51:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885FA100745
        for <linux-wireless@vger.kernel.org>; Fri,  8 Apr 2022 07:49:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 342D6B82BA0
        for <linux-wireless@vger.kernel.org>; Fri,  8 Apr 2022 14:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CC1C385A6;
        Fri,  8 Apr 2022 14:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649429338;
        bh=UCw9lJ89gM1G47+6jUvUy042yvVjuZPlcFqVj9h7QeA=;
        h=Date:From:To:Cc:Subject:From;
        b=jXfP84rW3WbgHLhiwuZG4Z6xn89VZ1TYhECvBcX9bEE8C54mkY40zBftXPo5n16zc
         2zJVQVamh4NYhaQ5+Sp3aPI0Y9U8FzYoRSkxa2dB4Yrydagf/oWNOeBc2zzrEYghyz
         EGpkt/oj0DDt7QHy+sK+8K8UvA5og2HBL2KzcaePEp7RiszrTddBMn50FhNvIwYkdq
         mIn6nYGk9N25sL4Z9ep0Z5IElQ9JplJ7fkvb4B4UJ3Q6sP7+qHYiM+b6GitGtk0vkn
         2hZj7HANB2H9V+13613ONjgbzB/43wsakDRRAYvavYB0IVG5fS6//mZZE3t8MA/SDg
         LtV6MHu+x8kGw==
Date:   Fri, 8 Apr 2022 09:48:58 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     wireless-regdb@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [ANN] wireless-regdb: master-2022-04-08
Message-ID: <YlBLWuf0eKyS1HL0@ubuntu-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A new release of wireless-regdb (master-2022-04-08) is available at:

https://www.kernel.org/pub/software/network/wireless-regdb/wireless-regdb-2022.04.08.tar.xz

The short log of changes since the master-2022-02-18 release is below.

Thanks,
Seth

---

Richard Huynh (1):
      wireless-regdb: Update regulatory rules for Australia (AU)

Roman Kunzman (1):
      wireless-regdb: Update regulatory rules for Israel (IL)

Seth Forshee (2):
      wireless-regdb: add missing spaces for US S1G rules
      wireless-regdb: update regulatory database based on preceding changes
