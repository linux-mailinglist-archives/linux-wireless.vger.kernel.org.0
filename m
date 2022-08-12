Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65705591352
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 17:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238958AbiHLPxV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 11:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238897AbiHLPxO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 11:53:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AC6ACA3D
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 08:53:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B8DD6150B
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 15:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F01C433D6;
        Fri, 12 Aug 2022 15:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660319592;
        bh=T9WIs/bagbUtVe/9Si/wz7WQ4b6VmlL+WWKGdD4cZ4k=;
        h=Date:From:To:Cc:Subject:From;
        b=cJl0X18+0StIsvDvt2d3jxPR9DY2qaMMdJrlW4H5DcougncoqvV3ZyY5Nj9vILqpW
         YPCF7Fv0a4Gw2mnpn+vaOHkZbo3HNtUgRQQRv5W2BgkfOsf+M1SC+A8Kb3qgTHBhs7
         Ftug6cRKVhjNmA31Y1WSyTKiw/kKh6eySXf2nQOZRhku0PXeW8LrM+Mkpb0LDSJows
         SAz1ipSzCcxe/RDnXsNFg19YPb2Jz8gEmyMUh8CLugyzFa7AD54n5GDYgsxuSjvv+3
         ivyYeyOXWpmplVUQ72+8YNLTTGngFOHwsZYLj7NnjNNohEPc+CMPqyx/POptO85ehv
         UfruTy85RFAGg==
Date:   Fri, 12 Aug 2022 10:53:11 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     wireless-regdb@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [ANN] wireless-regdb: master-2022-08-12
Message-ID: <YvZ3ZyPXvYdc8AYm@ubuntu-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A new release of wireless-regdb (master-2022-08-12) is available at:

https://www.kernel.org/pub/software/network/wireless-regdb/wireless-regdb-2022.08.12.tar.xz

The short log of changes since the master-2022-06-06 release is below.

Thanks,
Seth

---

Seth Forshee (3):
      wireless-regdb: add 5 GHz rules for GY
      wireless-regdb: update 5 GHz rules for PK and add 60 GHz rule
      wireless-regdb: update regulatory database based on preceding changes
