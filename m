Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7A03F9E90
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Aug 2021 20:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbhH0SLj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Aug 2021 14:11:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhH0SLi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Aug 2021 14:11:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3132360FDA;
        Fri, 27 Aug 2021 18:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630087849;
        bh=efycGMgOuRuAVC1cyTXxDuc5nH0HnGdY10ZNeZ60SFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N5qXYp6sslJgVdOBX06xEo7QcydjnZikyZvm+er0eeLigykfolKuTYigP0E5Q13mB
         hGSSsH5Sjr/kDtpVfuFyCj9BUiFmVnyO3J4Hbv2RMtNl+yZut3ecJ4v9SxrsMy7t9H
         fsFcDtkgJ6SAxbyVo1C9hY2N/KhrSwR2vRZuUOsMxOYgpCmDLCkwHQGrl05oxW0VXC
         rfM8hTtHaTsyfH4ffjQ8noWhIahbBVhR2c8GNDv+RXl80GgB4n5QXKoiUdzRJx75YX
         kbd8Uc5r02kqV356/smTgXQFe/3neZZlLcMa56A6fUVD4CPtHTa48nqLBFdAmvgPoq
         AxndqXFRM9AUg==
Date:   Fri, 27 Aug 2021 13:10:48 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Victor Bayas <victorsbayas@gmail.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] Update regulatory rules for Ecuador (EC)
Message-ID: <YSkqqHcnqQP1P/Bf@ubuntu-x1>
References: <20210826201026.5071-1-victorsbayas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826201026.5071-1-victorsbayas@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 26, 2021 at 03:10:26PM -0500, Victor Bayas wrote:
> Update the frequency ranges and power limits according to the current
> Ecuadorian norm [1], allow up to 160 MHz bandwidth on 5GHz.
> 
> [1] https://www.arcotel.gob.ec/wp-content/uploads/2018/04/NORMA-ESPECTRO-DE-USO-LIBRE-Y-ESPECTRO-PARA-USO-DETERMINADO-EN-BANDAS-LIBRES.pdf
> 
> Signed-off-by: Victor Bayas <victorsbayas@gmail.com>

Applied, thanks!
