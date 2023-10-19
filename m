Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E457CF13A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 09:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjJSH21 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 03:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjJSH20 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 03:28:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC6C9F
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 00:28:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906CCC433C7;
        Thu, 19 Oct 2023 07:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697700504;
        bh=wLug83WzbZFUzJwrfWYApiabQSQSYJjvixDTtNb76Kk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=K7+zqygtwVXdr5mju/uqJRzS6CHMq0Fh/9y9IoQT9mqfDcZZMflDu9fGSznpbZ+YC
         2FaQzBdadzuCLiBaQznya4VYCWuS+ZZcPug4C0GTxFiTGWZFFMsl2pbvsgBgRVnv6Y
         bpBQvaNdp82s7wQwqfkQcY+nJ4cYj9A8BkOVHFOXvQNNyffL8zNHQTSqXaaEahYgWf
         QUbt/4uGgIgVLZ7l2wtXSjDy3swFBZDU+Yk9lUGbeq0U5h4B9d4lG8IAXgaR76GVw1
         a1/PoXPojnf6UWkaHOCl3G9R1bEMuh7ihEgN7unE20hf0tOQiPCoX4MIWjSV0jVo6t
         BiYfm+W9SoDYQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: rtw88: debug: add to check if debug mask is
 enabled
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231016053554.744180-2-pkshih@realtek.com>
References: <20231016053554.744180-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169770050162.117236.15126110048637490351.kvalo@kernel.org>
Date:   Thu, 19 Oct 2023 07:28:23 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> The coming dump function for FW malfunction will add a function to
> dump registers to reflect status. However, if we are not debugging
> the mechanism, we don't print anything, so avoid reading registers by
> checking debug mask to reduce IO.
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

1926a27299db wifi: rtw88: debug: add to check if debug mask is enabled
20907fc06997 wifi: rtw88: dump firmware debug information in abnormal state

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231016053554.744180-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

