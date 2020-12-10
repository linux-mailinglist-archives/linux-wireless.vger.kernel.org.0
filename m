Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AF42D5CA0
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Dec 2020 15:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389793AbgLJOAL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Dec 2020 09:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbgLJOAD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Dec 2020 09:00:03 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AB7C0613CF
        for <linux-wireless@vger.kernel.org>; Thu, 10 Dec 2020 05:59:23 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1knMTX-0068ij-5i; Thu, 10 Dec 2020 14:59:19 +0100
Message-ID: <6fe05a79dfbc402ea350bb8e5f8b0b95a9e409fa.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: enable QoS support for nl80211 ctrl port
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 10 Dec 2020 14:59:02 +0100
In-Reply-To: <20201209225214.127548-1-markus.theil@tu-ilmenau.de>
References: <20201209225214.127548-1-markus.theil@tu-ilmenau.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-12-09 at 23:52 +0100, Markus Theil wrote:
> 
> Furthermore, this patch also checks and prevents frame
> aggregation for control port frames in order to speed up
> the initial connection setup a little.
> 

That might make sense, but I really think it should be a separate patch.

Thanks,
johannes

