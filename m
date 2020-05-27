Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CBF1E465F
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 16:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389310AbgE0OrL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 10:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388680AbgE0OrL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 10:47:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69114C05BD1E
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 07:47:11 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jdxKn-004Ack-Nz; Wed, 27 May 2020 16:47:09 +0200
Message-ID: <01ba6a6602e150b756fac8da1673cca34984c5d3.camel@sipsolutions.net>
Subject: Re: [PATCH v2] nl80211: add control port tx status method
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 27 May 2020 16:47:08 +0200
In-Reply-To: <20200527143653.3197-1-markus.theil@tu-ilmenau.de>
References: <20200527143653.3197-1-markus.theil@tu-ilmenau.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-05-27 at 16:36 +0200, Markus Theil wrote:
> This patch adds the actual code for returning the tx status of control
> port frames sent over nl80211.
> 
> NL80211_CMD_CONTROL_PORT_FRAME_TX_STATUS is a new command which is used
> when returning the tx status. Its availability can be queried by checking
> against NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_TX_STATUS.
> 
> The ctrl port tx status over nl80211 path re-uses some code from the path
> for advertising the tx status over socket control messages, when
> SKBTX_WIFI_STATUS is set.
> 
> The tx status can be used in a similar fashion as the mgmt tx status
> already allows for. A cookie is included extended ack data of
> NL80211_CMD_CONTROL_PORT_FRAME, which can be matched against the cookie
> in NL80211_CMD_CONTROL_PORT_FRAME_TX_STATUS. The frame content is also
> included, as for example hostapd currently uses it to match request and
> reply.

Looks good on a cursory review, but you forgot to set the feature flag?

johannes

