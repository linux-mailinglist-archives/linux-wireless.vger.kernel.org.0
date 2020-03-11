Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22754181C2F
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2020 16:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgCKPVO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Mar 2020 11:21:14 -0400
Received: from mail-qv1-f43.google.com ([209.85.219.43]:36150 "EHLO
        mail-qv1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729408AbgCKPVO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Mar 2020 11:21:14 -0400
Received: by mail-qv1-f43.google.com with SMTP id r15so1038963qve.3
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2020 08:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobcopeland-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y/5uCc6iDiMl1s7i8RtXL7ftP3Qn2dNas9sWS9jP7Rs=;
        b=PlhUay0kFtxmxxAYYbX4vTXfO1BLewdLbSnKEIlDSVeZAuxKjP/ol/5gOhh+TTvi1k
         vHfGWrd/CqY7wAvAGqkgyDJOT8v+GePaiNLqdSm5x16pxVQMlasXH7vNfdao8qMX71qm
         pyzTd1sx4Dr42KVKuD6NsBJ5CXDrwlGXj5m7E7yF/snDLNk0LAHf0DRLxzqLJTDSPcjG
         AA6OEuFtMw1sOAC3iQcViWutjKax3Jk/a8ZG99Pk/k8xMFDaAX/g0IZrW/gSBzrErzrg
         uT3manopB3Vr6SeQaxoeFKNXfli5Q8EsUOpyjXNx+VbwD3EzwRjjctQow9YCKhcD8kMx
         CoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y/5uCc6iDiMl1s7i8RtXL7ftP3Qn2dNas9sWS9jP7Rs=;
        b=XIW91ODgrmxjf37SMktQV72+dbqU6TQCJoNnBMczDc6OY0uc7F/BxnarTbGuymdbB4
         M2+E21Yq4muk3i83IE7KZ0vRfa1Ob5A5VY6e7Gbv0kOVh3HQxq0pVotvQbLWqqKB+Gf/
         qy/Mhga0xdgHb768bi/AJaN9xVoxJIS5XDjRRZNv3TAp7+BsxM9eRJKioeD3X3p9zuCK
         UuV8PQpYZNXPIpx5yfSANLpVtboWQTuj7ypsnzsRyvEoYAeVUgIW4voILrgOE0ET3Ddv
         1owi4W04e7YCOkRiEc0O9yTwUrCG/B5jUdsp/7/+tx8/tAjKYWz2D9m32CsGJeqqEBjM
         Pldw==
X-Gm-Message-State: ANhLgQ09L1wtUu6ICPIJQFaZHQRaSu0qKZsLUZ84p1kNFByWL/ZBDQDq
        qQCce8TTacXJKlDHa/tov8svdY9kgwM=
X-Google-Smtp-Source: ADFU+vswVRh4pOMkphii0YtXHr/5lk9J4Sq0UsqEpBvklF7MXD2k6M+NdvgRI54W2L0u6Q9blWpjVw==
X-Received: by 2002:a05:6214:5b2:: with SMTP id by18mr869156qvb.92.1583940071871;
        Wed, 11 Mar 2020 08:21:11 -0700 (PDT)
Received: from elrond.bobcopeland.com ([2607:fea8:5ac0:1bf2:91a5:cfde:3bfc:7446])
        by smtp.gmail.com with ESMTPSA id o14sm5987631qtq.12.2020.03.11.08.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 08:21:10 -0700 (PDT)
Received: by elrond.bobcopeland.com (Postfix, from userid 1000)
        id D055BFC0086; Wed, 11 Mar 2020 11:21:09 -0400 (EDT)
Date:   Wed, 11 Mar 2020 11:21:09 -0400
From:   Bob Copeland <me@bobcopeland.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/4] wmediumd vhost-user
Message-ID: <20200311152109.GA12125@bobcopeland.com>
References: <20200305145655.67427-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305145655.67427-1-johannes@sipsolutions.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Mar 05, 2020 at 03:56:51PM +0100, Johannes Berg wrote:
> Hi,
> 
> This adds vhost-user support, to match the hwsim code I
> just sent to the list.

Thanks!  Applied.

-- 
Bob Copeland %% https://bobcopeland.com/
