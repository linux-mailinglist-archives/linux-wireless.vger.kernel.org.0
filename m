Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92EB035827A
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Apr 2021 13:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhDHLxy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Apr 2021 07:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhDHLxx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Apr 2021 07:53:53 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67CAC061760
        for <linux-wireless@vger.kernel.org>; Thu,  8 Apr 2021 04:53:42 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lUTED-008zHE-5o; Thu, 08 Apr 2021 13:53:41 +0200
Message-ID: <19bb13db617309106091d485c7218cd0ee7bace7.camel@sipsolutions.net>
Subject: Re: [PATCH v9 0/4] Multiple BSSID support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 08 Apr 2021 13:53:40 +0200
In-Reply-To: <20210310182604.8858-1-alokad@codeaurora.org> (sfid-20210310_192727_681722_4BC25758)
References: <20210310182604.8858-1-alokad@codeaurora.org>
         (sfid-20210310_192727_681722_4BC25758)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-03-10 at 10:26 -0800, Aloka Dixit wrote:
> This patchset adds support for multiple BSSID and
> enhanced multi-BSSID advertisements.

All of this, in particular the subjects, should really mention that it's
for AP side.

Does it apply also for mesh, btw?

johannes

