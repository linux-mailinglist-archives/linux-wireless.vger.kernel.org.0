Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BF453EB45
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jun 2022 19:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240219AbiFFPAa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jun 2022 11:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240287AbiFFPAZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jun 2022 11:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277DA3082C9
        for <linux-wireless@vger.kernel.org>; Mon,  6 Jun 2022 08:00:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B96D9614CC
        for <linux-wireless@vger.kernel.org>; Mon,  6 Jun 2022 15:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DFFC385A9;
        Mon,  6 Jun 2022 15:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654527609;
        bh=XTQKOOWd0hG8eIEvTECrPdRIqbMHxT5jlZDE4jyUDaM=;
        h=Date:From:To:Cc:Subject:From;
        b=GLS7SYRUVTxCkwb9Twjj+iK+DqtopInVX65M2SIs4gQMT9yfgNFlWkCf7whiUsfaV
         wfB/oXIeEfmMbhcMxNK1Y7txte7g7B6WUX0wgBJ4+4qa8mMaiC1LPTTEtfyXV4DOTs
         6Xek108I1FXvG+D1XbhB41r1Qt8BtUECBMGlN/WziRc2IUHm1x5MghNWaP6YtPFzSa
         +tfnhOKxlOiVZ7s65ZGyevSy7j6Yi7qXi5SBHHauucX03PB+F5qvr8e89zAE6jGTBe
         kZgRZHHSue6hWWXBVPtV9I588DK/DD6zggB/8Yfr2Z97pM8bjmzQnnPr9FB7k/h5lb
         1Bxcw3DAHdzig==
Date:   Mon, 6 Jun 2022 10:00:07 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     wireless-regdb@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [ANN] wireless-regdb: master-2022-06-06
Message-ID: <Yp4Wd4NDdCaGb9d/@ubuntu-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A new release of wireless-regdb (master-2022-06-06) is available at:

https://www.kernel.org/pub/software/network/wireless-regdb/wireless-regdb-2022.06.06.tar.xz

The short log of changes since the master-2022-04-08 release is below.

Thanks,
Seth

---

Dennis Bland (3):
      Regulatory update for 6 GHz operation in Canada (CA)
      Regulatory update for 6 GHz operation in United States (US)
      Regulatory update for 6 GHz operation in FI

Seth Forshee (3):
      wireless-regdb: Remove AUTO-BW from 6 GHz rules
      wireless-regdb: Unify 6 GHz rules for EU contries
      wireless-regdb: update regulatory database based on preceding changes

Stijn Tintel (1):
      wireless-regdb: update regulatory rules for Bulgaria (BG) on 6GHz
