Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9E0659405
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Dec 2022 02:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbiL3BSt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Dec 2022 20:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiL3BSU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Dec 2022 20:18:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39722D6A
        for <linux-wireless@vger.kernel.org>; Thu, 29 Dec 2022 17:18:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9F1CB819EB
        for <linux-wireless@vger.kernel.org>; Fri, 30 Dec 2022 01:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792FDC433D2;
        Fri, 30 Dec 2022 01:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672363097;
        bh=vbn5uh0vzPF2ZWIKruiBxAVr92FKTFFf4G3MmBj4e6U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MHVn/QPzflioOQ41B6TXgWPfjZChM4P08g5fTRESDp1GvmgJ5tI/wzTBdtPP2+Nb/
         U4ebLJJHLoJyVhBZgSLL6aN3CAYidfoCq7Q9zhuXIcXfunvUJ3ecBqx821fv7O1chy
         yRV2YlSCDc/diLfv+RacDgFU4DNmA7TSHtvbGAgB2oNzJETsBQxv8RcvTYmKQSoK//
         +wiH77djy3b1Yf8bFOJYHoWPGR7ZC77ODoYi4ykpu2EiIYh7NinfqDmWTWe1Pb9RDZ
         GTH9lCbEH6G7zgiBoAEnstH92QUUss0+pak6FucOmjQd4gApyyynkSbtdilX+kQ/QA
         pwQRVSlHfzNcA==
Date:   Thu, 29 Dec 2022 17:18:16 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jisoo Jang <jisoo.jang@yonsei.ac.kr>
Cc:     linux-wireless@vger.kernel.org, linuxlovemin@yonsei.ac.kr,
        dokyungs@yonsei.ac.kr
Subject: Re: [PATCH] wifi: mt7601u: fix an integer underflow
Message-ID: <20221229171816.42022e23@kernel.org>
In-Reply-To: <20221229092906.2328282-1-jisoo.jang@yonsei.ac.kr>
References: <20221229092906.2328282-1-jisoo.jang@yonsei.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 29 Dec 2022 18:29:06 +0900 Jisoo Jang wrote:
> Fix an integer underflow that leads to a null pointer dereference in
> 'mt7601u_rx_skb_from_seg()'. The variable 'dma_len' in the URB packet
> could be manipulated, which could trigger an integer underflow of
> 'seg_len' in 'mt7601u_rx_process_seg()'. This underflow subsequently
> causes the 'bad_frame' checks in 'mt7601u_rx_skb_from_seg()' to be
> bypassed, eventually leading to a dereference of the pointer 'p', which
> is a null pointer.
> 
> Ensure that 'dma_len' is greater than 'min_seg_len'.

Acked-by: Jakub Kicinski <kuba@kernel.org>
