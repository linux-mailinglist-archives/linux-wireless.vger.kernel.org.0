Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 360F418F87F
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 16:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgCWPZs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 11:25:48 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:49284 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgCWPZs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 11:25:48 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jGOxW-002WVN-UW; Mon, 23 Mar 2020 16:25:47 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     me@bobcopeland.com
Subject: [PATCH 0/7] more wmediumd updates
Date:   Mon, 23 Mar 2020 16:25:35 +0100
Message-Id: <20200323152542.68696-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some of these fix my previous patches, but I also have a patch
for some code I just posted here:
https://lore.kernel.org/r/20200323162358.b397b1a1acef.Ice0536e34e5d96c51f97c374ea8af9551347c7e8@changeid

to make it possible to use random-scan and other stuff, adding
each MAC address from hwsim into the wmediumd "MAC".

Also sanitizer support (helped catch the use-after-free) and a
small fix for not treating management frames as noack, not sure
why that was ever done?

johannes


