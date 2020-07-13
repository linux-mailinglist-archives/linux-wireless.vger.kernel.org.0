Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E4F21DF20
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2020 19:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbgGMRrt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jul 2020 13:47:49 -0400
Received: from freki.datenkhaos.de ([81.7.17.101]:40420 "EHLO
        freki.datenkhaos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbgGMRrs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jul 2020 13:47:48 -0400
X-Greylist: delayed 351 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Jul 2020 13:47:47 EDT
Received: from localhost (localhost [127.0.0.1])
        by freki.datenkhaos.de (Postfix) with ESMTP id B9C692E4F856;
        Mon, 13 Jul 2020 19:41:55 +0200 (CEST)
Received: from freki.datenkhaos.de ([127.0.0.1])
        by localhost (freki.datenkhaos.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id n3DP_HpruE3U; Mon, 13 Jul 2020 19:41:53 +0200 (CEST)
Received: from latitude (geri.datenkhaos.de [81.7.17.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by freki.datenkhaos.de (Postfix) with ESMTPSA;
        Mon, 13 Jul 2020 19:41:53 +0200 (CEST)
Date:   Mon, 13 Jul 2020 19:41:48 +0200
From:   Johannes Hirte <johannes.hirte@datenkhaos.de>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-wireless@vger.kernel.org,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iwlwifi: Don't IWL_WARN on FW reconfiguration
Message-ID: <20200713174148.GA954244@latitude>
References: <20191017144841.GA16393@chrisdown.name>
 <20191017145321.GA1609@chrisdown.name>
 <20200713115137.GA1065134@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200713115137.GA1065134@chrisdown.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020 Jul 13, Chris Down wrote:
> Just to check in again since this is still happening: is this expected?
> 
> I expect that if this is IWL_WARN, it should indicate some unexpected or 
> non-ideal state, but the card seems to operate just fine afterwards.

I'm confused too, cause I'm seeing this on an AC 8260 now, whereas in the
past there wasn't such a message. Is this something the user should be
aware of? If not, I'm with Chris that this should be silenced. 

-- 
Regards,
  Johannes Hirte

