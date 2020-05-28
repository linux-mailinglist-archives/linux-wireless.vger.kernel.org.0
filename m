Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5421A1E6797
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 18:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405106AbgE1Qje (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 12:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405054AbgE1Qjd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 12:39:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8217DC08C5C6
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 09:39:33 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeLZ5-004z5V-Qs; Thu, 28 May 2020 18:39:31 +0200
Message-ID: <4f85665c17b258d64b132a279782eafeb5017cf7.camel@sipsolutions.net>
Subject: Re: [PATCH 01/24] nl80211: really allow client-only BIGTK support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Date:   Thu, 28 May 2020 18:39:30 +0200
In-Reply-To: <20200528165011.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid> (sfid-20200528_165058_656030_0F18B073)
References: <20200528165011.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
         (sfid-20200528_165058_656030_0F18B073)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Looks like something here broke all the 80+80/160 MHz test cases in
wpa_supplicant, I'll bisect & fix later.

johannes

