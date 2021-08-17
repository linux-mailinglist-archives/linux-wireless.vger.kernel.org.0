Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CBB3EEB0A
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Aug 2021 12:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbhHQKfw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Aug 2021 06:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbhHQKfw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Aug 2021 06:35:52 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F451C061764
        for <linux-wireless@vger.kernel.org>; Tue, 17 Aug 2021 03:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=nvw486gr+xMSHMZA5abhSltBnJgM/D6NhdYd+Z1kui4=;
        t=1629196519; x=1630406119; b=P3XbKFv9SzXeRDHQMIdz8XFkvyy1l7iHSYDHq11GMSDGW+g
        f8G5zk7Rz1OTKYNpljLTWzwSARbn9bsfXD12aB+5cBx4dJHVaRXuJ1R9U8X75t2wqpRr5DkSwy6He
        5MSweQ1aKvTB+0pXnJKZJ+rWPe+c4pbIqPpt3QZVTE3csHjCSRFeAMpc17MSDTCfh2p8QMq4Ihyfr
        NPTG5pgidsssn8xoyBBKNl+tDp3Qykb4nil8o0SWXGslAXZvWcMnmdqDYBS/Zwe7pSEvUncZj80ZY
        WysGgn9GxY3OT1oWCpEGIFOoIwVfSwoSRzLjk/qiLex6//4Ox5oposBUjZDeKCMA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mFwRB-00CDxK-LD; Tue, 17 Aug 2021 12:35:17 +0200
Message-ID: <849e2cf64fbf774fec9c30003e828aaf2d12a6d7.camel@sipsolutions.net>
Subject: Re: [PATCH v11 0/4] multiple bssid and EMA support in AP mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>, linux-wireless@vger.kernel.org
Date:   Tue, 17 Aug 2021 12:35:16 +0200
In-Reply-To: <20210715070745.5033-1-alokad@codeaurora.org>
References: <20210715070745.5033-1-alokad@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-07-15 at 00:07 -0700, Aloka Dixit wrote:
> This patchset adds support for multiple BSSID and
> enhanced multi-BSSID advertisements for AP mode.
> Individual patches describe the changes in this version.

How about adding the trivial advertisement to hwsim so we can have some
tests in hostapd?

johannes

