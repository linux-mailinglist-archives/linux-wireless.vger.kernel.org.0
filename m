Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669667242F8
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 14:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbjFFMuF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 08:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237896AbjFFMuC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 08:50:02 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFBF10F2
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 05:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=IaKLClW8EVSg4irYJthsOc1cLxiUBQInokonmlGCztc=; t=1686055779; x=1687265379; 
        b=VnWViWcTf55NSjyFrcMFT0NZOjR6rwTxipoJ00UMQMVGi9fxS1QFpGTg3q9F3hHQDuFKGZM8hXt
        4GoBdV+bEq9ZtXyRb2WXbAPswDqnDK3paqCMjHtBJto7vddhNHlFNDrpZrn9Spwn0XCuWlEAVx3I2
        tSbaINxaBpjFSKIsDPvbXr+6v2TW4hAgzZDTEbvvacMFmwI2229DwNmUYSzgRPhn3U8EbzJBcAcEr
        fPqBzvTJkxrZgvQpIzE3LZ5BdneQ/o3+0o0f/Ek2vOiKssiOCciBlxd9WMqEN/iJ3XtqdNDzZ3CRh
        xM0UTeRm/bYeKWg7/id39Q5iAGkGcoL2kNNw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q6W81-00FZDP-1x
        for linux-wireless@vger.kernel.org;
        Tue, 06 Jun 2023 14:49:37 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 00/14] wifi: work cleanups part 1
Date:   Tue,  6 Jun 2023 14:49:19 +0200
Message-Id: <20230606124933.181107-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is the first part of work cleanups, in particular this also
fixes the SMPS work deadlock issue with multi-link, since the wiphy
works are canceled more easily.

I'm planning on taking this into the tree and then building on it
for further simplifications - once most the works are converted
(except mac80211 restart hw, I think; help welcome) and we see that
everything holds the wiphy_lock(), we can start cleaning up all the
locking...

johannes


