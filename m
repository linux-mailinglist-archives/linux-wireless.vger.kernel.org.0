Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF9A63D699
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Nov 2022 14:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbiK3NWx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Nov 2022 08:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbiK3NWt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Nov 2022 08:22:49 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD69D8D
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 05:22:48 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F20E068B05; Wed, 30 Nov 2022 14:22:44 +0100 (CET)
Date:   Wed, 30 Nov 2022 14:22:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: ath11k vs ar_qrtr?
Message-ID: <20221130132244.GB3055@lst.de>
References: <20221130122807.GA31720@lst.de> <87o7so4nr2.fsf@kernel.org> <20221130125236.GA865@lst.de> <87k03c4mdb.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k03c4mdb.fsf@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Nov 30, 2022 at 03:12:32PM +0200, Kalle Valo wrote:
> Heh, I'm learning something new here. But I wonder why nobody else has
> seen this?

Good question.  How common is the ath11k hardware, especially on latptop
where it is required for installation given that only installers tend
to split up driver is non-standard ways.
