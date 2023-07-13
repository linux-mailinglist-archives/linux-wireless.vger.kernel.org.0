Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D507515B0
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jul 2023 03:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjGMBDP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jul 2023 21:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjGMBDO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jul 2023 21:03:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4044E70
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jul 2023 18:03:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49E06619B9
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jul 2023 01:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5D3C433C7;
        Thu, 13 Jul 2023 01:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689210192;
        bh=pQFP441vtnUccaImrTHydDR08N3SglhrG2RgV+NACjM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r6QUnnePUe6bsKW3RWKd9F4bAEa1lsMvJC4MMBr2COlcBsSUxfCnIY1EdzLWylS+x
         rYdZMVkptibHcm2F/L/TqfVCs9T7XHjraDxD8TSpgXi7H0smljJc8+zZ68xK5jHcVy
         vIs7mSws/ROLxjvlj9F5AgispJgU6TL4YDxIxBvHPEpIEhUPkSnk+g/9foZ+SZOkKm
         /mnk4jKsUn1MUoO34pTuMS3q10vHn8EnBK6ROq6pGRJjbNHA2ujr/l1cyY4cT6847i
         LhVmusvUvXuV3YlUV5rlaFaS5sXCg4tWw0txlYf7Dc77nx5lUXbgpZhVLWsCifk9YW
         m+stiwCdkhqvw==
Date:   Wed, 12 Jul 2023 18:03:11 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net,
        Nicolas Escande <nico.escande@gmail.com>
Subject: Re: [PATCH wireless] wifi: cfg80211: fix receving mesh packets
 without RFC1042 header
Message-ID: <20230712180311.0dd4bdd3@kernel.org>
In-Reply-To: <20230711115052.68430-1-nbd@nbd.name>
References: <20230711115052.68430-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 11 Jul 2023 13:50:52 +0200 Felix Fietkau wrote:
> Fix ethernet header length field after stripping the mesh header
> 
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/CT5GNZSK28AI.2K6M69OXM9RW5@syracuse/
> Fixes: 986e43b19ae9 ("wifi: mac80211: fix receiving A-MSDU frames on mesh interfaces")
> Reported-by: Nicolas Escande <nico.escande@gmail.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Applied, thanks!
