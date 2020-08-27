Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1E02548D4
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 17:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgH0PO3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 11:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbgH0Lia (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 07:38:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71531C0611E2
        for <linux-wireless@vger.kernel.org>; Thu, 27 Aug 2020 04:37:44 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kBGDq-00BZJz-VS; Thu, 27 Aug 2020 13:37:39 +0200
Message-ID: <208a211130e2bd2881e8c828feb0170db6a08a77.camel@sipsolutions.net>
Subject: Re: [PATCH] iw: add TID specific Tx bitrate configuration
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tamizh Chelvam <tamizhr@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 27 Aug 2020 13:37:37 +0200
In-Reply-To: <1597903916-8674-1-git-send-email-tamizhr@codeaurora.org>
References: <1597903916-8674-1-git-send-email-tamizhr@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-08-20 at 11:41 +0530, Tamizh Chelvam wrote:
> Add TID specific Tx bitrate configuration by using
> handle_bitrates already APIs.

In addition to what Sergey said, I get:

interface.c: In function ‘handle_tid_config’:
interface.c:944:11: warning: implicit conversion from ‘enum nl80211_tid_config_attr’ to ‘enum nl80211_attrs’ [-Wenum-conversion]
  944 |           NL80211_TID_CONFIG_ATTR_TX_RATE);
      |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Please address that too.

johannes

