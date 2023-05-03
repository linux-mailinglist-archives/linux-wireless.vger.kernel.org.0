Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3EE6F5F2C
	for <lists+linux-wireless@lfdr.de>; Wed,  3 May 2023 21:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjECTel (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 May 2023 15:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjECTek (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 May 2023 15:34:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F66CE
        for <linux-wireless@vger.kernel.org>; Wed,  3 May 2023 12:34:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F65262F64
        for <linux-wireless@vger.kernel.org>; Wed,  3 May 2023 19:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975FAC433D2;
        Wed,  3 May 2023 19:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683142478;
        bh=EdwV+fT0zKSnHXXjSJtyx5FXeRs4OElY6yiqIYXFwX8=;
        h=Date:From:To:Subject:From;
        b=f58XxzMTkVjDAGo3mNAeFL3KS2pflbOx8BR2hMBUzOJiejY+BzGhlt9qt+M71KtWH
         uJk2WknSM9dsPl0Jzz6ohs7kT+TnhQeMX3bmUFwU5yyZV52dxR7mEqsbtHbSvTMx0x
         lwYVPaPma7TPsSYZvr+3Wzl9+ZNfIrhB+p5PjNa3kWlDgPya7NPpUt9hZ8R2sfFZQe
         PbSM8FA+Vgn5m8i5fE50/J74sb+M6CJNbU6a6hU85n5YQ1q5ELSSA8D04Twy8XYC1m
         FNVOLAWhnlxm/u7Y7wqelxTawhVfmeaFgfFBUGVSCnGBkuLzjiy2wndcHs3ifEV+WN
         d4BFO4jNC+Elw==
Date:   Wed, 3 May 2023 14:34:37 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Stepping down as wireless-regdb maintainer
Message-ID: <ZFK3TQWDQMoH9obk@ubuntu-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I started maintaining wireless-regdb over 8 years ago at a time when my
job responsibilities included investigating and working to fix reports
of wireless bugs in Linux. Not long after that my responsibilities
started shifting away from wireless work, and for the past several years
I've had no involvement in anything related to wireless beyond fairly
passive maintenance of wireless-regdb. Even in that role it's recently
been difficult to find time to validate proposed changes against the
source documents, which has frequently lead to slow response times.

As a result, I've decided that it is time for me to move on from
maintaining wireless-regdb. I won't step away immediately, but I plan to
stop applying patches and doing new releases around Sep 1 of this year.

If anyone is interested in taking over maintenance of this project,
please reach out and I'll be happy to discuss.

Thanks,
Seth
