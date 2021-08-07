Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126043E329C
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Aug 2021 03:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhHGBrN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Aug 2021 21:47:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229749AbhHGBrM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Aug 2021 21:47:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8A8061186;
        Sat,  7 Aug 2021 01:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628300816;
        bh=mtPrcZcxj6ZQ/cTyJmc6jpqxFDXO16rqxGcvLl7bi8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z46+4Js3BU7bYpyWel3NfMI4FV37b/wmU+K395oOtuqz7PLjjHS9OdVQHtJvcPItw
         M/6IpGADBYLhRf+jgXtMM5H+3/WQ9dW5A6qEQnXcHFl+pwxUMF4oye/y6yKr+Mg3DJ
         JgGOMiq4/59KX6T6LJZWFxV7gqcX4wDkdzU90au+O8SRcyE6RYCRYRCAAhDovi4FsC
         2I0KkHEuA74oFPJsQPlBMSxWw/34sLXe5L41hSVyHxnxVg3W1tjbaaIjysYxeApXbn
         ANjvArB4pTFxz2wCb6akNsjIswOVFe49wdIjCPD/H7OixDKFkW3pg/9hNo72wJ/IUN
         hxkrNsTId1FxA==
Date:   Fri, 6 Aug 2021 20:46:55 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [wireless-regdb] [PATCH] wireless-regdb: Update regulatory rules
 for Norway (NO) on 6 and 60 GHz
Message-ID: <YQ3mD2SZhQdv7ZCg@ubuntu-x1>
References: <20210804083337.8833-1-bjorn@mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210804083337.8833-1-bjorn@mork.no>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Aug 04, 2021 at 10:33:37AM +0200, Bjørn Mork wrote:
> The Norwegian regulatory authority (NKOM) has updated the existing
> regulations.
> 
> WiFi 6E is now allowed with the same restrictions as in many/most
> EU/EEA countries - i.e 200 mW indoor and 25 mW outdoor, Using the
> DE entry as a template for now, until this dual entry can be
> described in the database.
> 
> The update also extended the 60 GHz band to 71 GHz.
> 
> The official announcement of the regulation changes:
> https://lovdata.no/dokument/LTI/forskrift/2021-06-29-2312
> 
> The existing reference in the database has been updated with these
> changes, so no new reference is needed.
> 
> Signed-off-by: Bjørn Mork <bjorn@mork.no>

Applied, thanks!
