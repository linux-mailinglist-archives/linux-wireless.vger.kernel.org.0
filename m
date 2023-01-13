Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4FA6696CD
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jan 2023 13:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241283AbjAMMVc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Jan 2023 07:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240584AbjAMMVJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Jan 2023 07:21:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9244180609
        for <linux-wireless@vger.kernel.org>; Fri, 13 Jan 2023 04:14:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41F50B82137
        for <linux-wireless@vger.kernel.org>; Fri, 13 Jan 2023 12:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D1FC433EF;
        Fri, 13 Jan 2023 12:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673612085;
        bh=YAoO+Byw1unrROhiBcYVj0kEzsOoVTbw5Y49ArPv5bY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=PHuymldC+LboDEJcHh9DFgK4OZkao77NPNEzZ01qnNHdotw94NaiSXQI1JAsO7UBw
         rG1OW8Hv82z2CmcWNNRn5rWfGRv/t1uPn4tstpTFE+5ZR81Xk6byqmUn9hLlv5oJWD
         aEi10g+PQnGB9XnK0ilY+E6Xh9/8A7sKYLnYDFAWrUT4KrHEEhMRHe3FoeBEVx/WqQ
         sCRsG0Wi2wM1GkcCmdbnd6TYi6O/F2N+mndqz3UUocjKbS/IVUSEQ65/gyZPV+pVXc
         I84rac7nGzKYoXkGvAbpZUmf0qRw8V9Yhyi+yl3UiRuEtX+y/0MyM+uZEEsTUjvlZY
         obnVjEQdIkcaw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] wifi: ath11k: reduce the timeout value back for hw scan from 10 seconds to 1 second
References: <20221011072408.23731-1-quic_wgong@quicinc.com>
        <20221011072408.23731-3-quic_wgong@quicinc.com>
        <8735atg335.fsf@kernel.org>
        <cd96eea8-dce0-bcb9-e8ce-05fa0e0f22fb@quicinc.com>
        <e7e34c3d-8b73-f7d5-9ce8-5ed346ca9d28@quicinc.com>
        <7bcd1a12-fb60-98cd-1a29-f55efa8d1499@quicinc.com>
        <73908049-4a69-e65c-665b-97d068f1fef7@quicinc.com>
Date:   Fri, 13 Jan 2023 14:14:41 +0200
In-Reply-To: <73908049-4a69-e65c-665b-97d068f1fef7@quicinc.com> (Wen Gong's
        message of "Fri, 13 Jan 2023 14:54:50 +0800")
Message-ID: <87k01qd426.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> Should I change commit log with below explanation and send v4?

Please stop spamming the same question over and over, it's really
annoying. If I don't have time to look at something, spamming me won't
help, quite the opposite. It would be a lot better if you would help
with the other upstream related tasks we have, that way I might have
more time to look at your patches.

To answer your question I need to look at this patchset in detail and I
don't know when I'm able to do that. But at this moment I don't trust
this patchset is the right approach and I'm not willing to take it.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
