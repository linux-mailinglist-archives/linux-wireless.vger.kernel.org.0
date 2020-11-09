Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BF02AB424
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Nov 2020 10:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgKIJ54 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Nov 2020 04:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbgKIJ5z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Nov 2020 04:57:55 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF99C0613CF
        for <linux-wireless@vger.kernel.org>; Mon,  9 Nov 2020 01:57:55 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kc3vs-004EGg-Um
        for linux-wireless@vger.kernel.org; Mon, 09 Nov 2020 10:57:53 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 0/8] wireless: remove WDS mode
Date:   Mon,  9 Nov 2020 10:57:39 +0100
Message-Id: <20201109095747.113720-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We use 4-addr AP/client instead. Remove WDS code that was
basically not possible to enable anyway.

johannes


