Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A4A77845E
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Aug 2023 01:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjHJXyS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 19:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjHJXyR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 19:54:17 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C30726BC
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 16:54:17 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bbc06f830aso10763415ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 16:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691711657; x=1692316457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qsHfJVOQ255YFbZbdUUheUVnDVx8q2jsE3hZBxpZuz8=;
        b=L22cEDO0syHD/sEkeL2q1R34CGODwNsx+RTNXuZJDipxYXapULA/PGWP+dO+ahlrzc
         Yy/Vx6mhlucMHXDP5qtT5emGNxqbzfKe5vStBtdvYopCxLEHKLDv91hiCWWEXbQauz0x
         oaWyOApSpEF8g9WMQouDDjZWomr8WmwFKiNwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691711657; x=1692316457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsHfJVOQ255YFbZbdUUheUVnDVx8q2jsE3hZBxpZuz8=;
        b=QdwJ8b+Wm/BuEF48eeOk4ALt6hG5Vi3hpwQQCvYfQtcuuIuFad+ObNv8pUHYWc2VY9
         HW1l8gO2O3+ulfe1B/ZnR+5e4d9nVcBp/aoHZnZmXZuzldlrV5zOF7YNpRZNP+Ev8uE5
         UEQcWsW1CdHMTRRs2jp8BgMVXkcYBNscR4jmrQjKIXd5YWt1JxDGoaT8ggEJsBuKG6BM
         ITcmJctHJF9AHwKjJoINFL4hscCNIuOHSac1s+WfHNQ2YwpuwREI3Lu4I8msT1DCIn6q
         Q4+VhUkBm1xAgL0PSHo3occgaSoaPEyFF+YJpSFMfErTXmGuXdzU5D30FJ+YpTydwHuw
         zqJA==
X-Gm-Message-State: AOJu0YxlyMkJr0qByncgh0duCe1s7rgrLO7ZCcAFR+SXitIx7ezhpRfG
        WIr8l2O8ZjlvhTYYi5bOKA+9PQ==
X-Google-Smtp-Source: AGHT+IFEs8Y8VQvHLZjaHWttGxRUL099CwQBRoWQrHSXKm7HLXDDkykjSY8eM8IFokBTC7YZeRGidA==
X-Received: by 2002:a17:902:f543:b0:1b8:af5e:853c with SMTP id h3-20020a170902f54300b001b8af5e853cmr570099plf.26.1691711656749;
        Thu, 10 Aug 2023 16:54:16 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:4ec8:57d8:e207:3679])
        by smtp.gmail.com with ESMTPSA id m7-20020a170902768700b001b9be79729csm2349225pll.165.2023.08.10.16.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 16:54:16 -0700 (PDT)
Date:   Thu, 10 Aug 2023 16:54:14 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Polaris Pi <pinkperfect2021@gmail.com>, matthewmwang@chromium.org,
        kuba@kernel.org, kvalo@kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v8] wifi: mwifiex: Fix OOB and integer underflow when rx
 packets
Message-ID: <ZNV4piNiozRcGRYo@google.com>
References: <20230809215817.3080280-1-pinkperfect2021@gmail.com>
 <4933455600e633c8cbafc0fc3180a7023894f8c9.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4933455600e633c8cbafc0fc3180a7023894f8c9.camel@sipsolutions.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 10, 2023 at 09:32:57AM +0200, Johannes Berg wrote:
> On Wed, 2023-08-09 at 21:58 +0000, Polaris Pi wrote:
> > Make sure mwifiex_process_mgmt_packet,
> > mwifiex_process_sta_rx_packet and mwifiex_process_uap_rx_packet,
> > mwifiex_uap_queue_bridged_pkt and mwifiex_process_rx_packet
> > not out-of-bounds access the skb->data buffer.
> > 
> > Fixes: 2dbaf751b1de ("mwifiex: report received management frames to cfg80211")
> > Signed-off-by: Polaris Pi <pinkperfect2021@gmail.com>
> > ---
> > V5: Follow chromeos comments: preserve the original flow of mwifiex_process_uap_rx_packet
> > V6: Simplify check in mwifiex_process_uap_rx_packet
> > V7: Fix drop packets issue when auotest V6, now pass manual and auto tests
> > V8: Fix missing return after free skb
> > 
> 
> Arguably, as Brian also said, that missing return is completely
> unrelated and should perhaps be a separate commit?

I think the key here is that Polaris's buggy patch has already been
applied, so this v8 doesn't really work. He has since submitted a proper
fixup patch that applies appropriately, and I've Ack'd that.

Brian
