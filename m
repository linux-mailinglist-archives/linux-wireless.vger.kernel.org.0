Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6901C3731F9
	for <lists+linux-wireless@lfdr.de>; Tue,  4 May 2021 23:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbhEDVkw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 May 2021 17:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbhEDVkv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 May 2021 17:40:51 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800BEC061574;
        Tue,  4 May 2021 14:39:55 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4FZYCY6Q8RzQjPj;
        Tue,  4 May 2021 23:39:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1620164391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=eRKw0tA7rc2y4JAuwr9a+PRTMgQemkPvt9h/OcnNoU4=;
        b=JvVaGonIhw5N4mlYDiC+ictD5GSMeaNCRwzw/0ZpcyDnZI0q/vmm8WQTkKYAaAxWHk5Rsh
        2G1L2TfQokPzBhIpiMegmTNRVZqsTjWOJ/izdLmh9bBqU/vayngSXuhL8pN8sHYk85oKgP
        yJkbVLnpdlhs6yL9tCaJAbJAHA/zFhP8zsfQjLUOqos04Im30lLnpHssDMPtNZI9Xu8+k5
        xPYeCa4EM1rDEFxIOuZqcDWl1rZxsD3i9AGb7A4NBnuIWyaoaTpQclA2Ni6uj/Ga/fASpk
        u1fDwTfU7VsXkCT1myCu6FIIzVCNDDBZo1CFRAXyaciLZJSEOufAs+o7JR4kKA==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id JGXCd-3XSixy; Tue,  4 May 2021 23:39:50 +0200 (CEST)
To:     "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc:     linux-wireless@vger.kernel.org
From:   Hauke Mehrtens <hauke@hauke-m.de>
Subject: wireless backports 4.19.189-1 and 5.10.34-1 released
Message-ID: <f5ed6f3c-371c-2a91-d964-a523440840e3@hauke-m.de>
Date:   Tue, 4 May 2021 23:39:44 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="47iPhsoSMa5R1UOoUKl1pXXFij00xLtk0"
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -3.96 / 15.00 / 15.00
X-Rspamd-Queue-Id: 91B4D17FF
X-Rspamd-UID: 6f8596
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--47iPhsoSMa5R1UOoUKl1pXXFij00xLtk0
Content-Type: multipart/mixed; boundary="t7Fw5ro5HQMuBV8Z2y77w5eqNhCWwieGd";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: linux-wireless@vger.kernel.org
Message-ID: <f5ed6f3c-371c-2a91-d964-a523440840e3@hauke-m.de>
Subject: wireless backports 4.19.189-1 and 5.10.34-1 released

--t7Fw5ro5HQMuBV8Z2y77w5eqNhCWwieGd
Content-Type: multipart/mixed;
 boundary="------------EEEDDA11A3D401DCE99FFCAF"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------EEEDDA11A3D401DCE99FFCAF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi

backports-5.10.34-1 was released. This is based on Linux 5.10.34.
https://cdn.kernel.org/pub/linux/kernel/projects/backports/stable/v5.10.3=
4/backports-5.10.34-1.tar.xz

backports-4.19.189-1 was released. This is based on Linux 4.19.189.
https://cdn.kernel.org/pub/linux/kernel/projects/backports/stable/v4.19.1=
89/backports-4.19.189-1.tar.xz

There is now a updated wiki page with the releases:
https://backports.wiki.kernel.org/index.php/Releases

The source code can be found here:
https://git.kernel.org/cgit/linux/kernel/git/backports/backports.git/

Hauke

--------------EEEDDA11A3D401DCE99FFCAF
Content-Type: application/pgp-keys;
 name="OpenPGP_0x93DD20630910B515.asc"
Content-Transfer-Encoding: quoted-printable
Content-Description: OpenPGP public key
Content-Disposition: attachment;
 filename="OpenPGP_0x93DD20630910B515.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBFtLdKcBEADFOTNUys8TnhpEdE5e1wO1vC+a62dPtuZgxYG83+9iVpsAyaSrCGGz5tmuB=
gkE
MZVK9YogfMyVHFEcy0RqfO7gIYBYvFp0z32btJhjkjBm9hZ6eonjFnG9XmqDKg/aZI+ud9KGU=
h0D
eaHT9FY96qdUsxIsdCodowf1eTNTJn+hdCudjLWjDf9FlBV0XKTN+ETY3pbPL2yih8Uem7tC3=
pmU
7oN7Z0OpKev5E2hLhhx+Lpcro4ikeclxdAg7g3XZWQLqfvKsjiOJsCWNXpy7hhru9PQE8oNFg=
SNz
zx2tMouhmXIlzEX4xFnJghprn+8EA/sCaczhdna+LVjICHxTO36ytOv7L3q6xDxIkdF6vyeEt=
Vm1
OfRzfGSgKdrvxc+FRJjp3TIRPFqvYUADDPh5Az7xa1LRy3YcvKYxpsDDKpJ8nCxNaYs6hqTbz=
4lo
Hpv1hQLrPXFVpoFUApfvH/q7bb+eXVjRW1m2Ahvp7QipLEAKGbiV7uvALuIjnlVtfBZSxI+Xg=
7SB
ETxgK1YHxV7PhlzMdTIKY9GL0Rtl6CMir/zMFJkxTMeO1P8wzt+WOvpxF9TixOhUtmfv0X7ay=
93H
WOdddAzov7eCKp4Ju1ZQj8QqROqsc/Ba87OH8cnG/QX9pHXpO9efHcZYIIwx1nquXnXyjJ/sM=
dS7
jGiEOfGlp6N9IwARAQABzSFIYXVrZSBNZWhydGVucyA8aGF1a2VAaGF1a2UtbS5kZT7CwZQEE=
wEI
AD4CGwEFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AWIQS4+/Pwq1ZO6E9/sdOT3SBjCRC1FQUCX=
r/2
hwUJBcXE4AAKCRCT3SBjCRC1FX1BEACXkrQyF2DJuoWQ9up7LKEHjnQ3CjL06kNWH3FtvdOjd=
e/H
7ACo2gEAPz3mWYGocdH8NjpmlnneX+3SzDspkW9dOJP/xjq9IlttJi3WeQqrBpe/01285IUDf=
OYi
+DasdqGFEzAYGznGmptL9X7hcAdu7fWUbxjZgPtJKw2pshRu9cCrPJqqlKkRFVlthFc+mkcLF=
xeP
l7SvLY+ANwvviQBblXJ2WXTSTX+Kqx8ywrKPwsJlTGysqvNRKScDMr2u+aROaOC9rvU3bucmW=
NSu
igtXJLSA1PbU7khRCHRb1q5q3AN+PCM3SXYwV7DL/4pCkEYdrQPztJ57jnsnJVjKR5TCkBwUa=
PIX
jFmOk15/BNuZWAfAZqYHkcbVjwo4Dr1XnJJon4vQncnVE4Igqlt2jujTRlB/AomuzLWy61mqk=
wUQ
l+uM1tNmeg0yC/b8bM6PqPca6tKfvkvseFzcVK6kKRfeO5zbVLoLQ3hQzRWTS2qOeiHDJyX7i=
KW/
jmR7YpLcx/Srqayb5YO207yo8NHkztyuSqFoAKBElEYIKtpJwZ8mnMJizijs5wjQ0VqDpGbRQ=
anU
x025D4lN8PrHNEnDbx/e7MSZGye2oK73GZYcExXpEC4QkJwu7AVoVir9lZUclC7Lz0QZS08ap=
VSY
u81UzhmlEprdOEPPGEXOtC1zs6y9O8LBlAQTAQgAPgIbAQULCQgHAgYVCAkKCwIEFgIDAQIeA=
QIX
gBYhBLj78/CrVk7oT3+x05PdIGMJELUVBQJdBNjNBQkDmpemAAoJEJPdIGMJELUVPpwP/2APQ=
K0A
8SUrCE0bNn8o1Avf35DgY5cMA7HI/v3uB6DLKS9qpT+nQw4p3HwXYMckIaWuQFaqIS1hQBGdQ=
k6B
+2hMtqWJ3ASnp6Jkz0SqKfmtFHoHk0hhQiMcCnGM8dKZ/CzmmdoF0jo1Xy3lGk5MA0iUF8/pt=
MES
lUZsLQHC8EVp0ai9wouucA1ni8vnrODTKRGiC0Pyt6g28ms0MrtcKsLZLQRhwYPlxe54lul/o=
lFy
6widiMyb+DaxEIfhxCz9U6OPcLrqw0Qy+9l0oTFmCH/2X1GZbRfrLsDRIO1HcA9hYYjBXRuFN=
La6
y44ABlC8WFz6J1IbRisepGI5OdbE6deQUVo52Z+T315Zqqlc4iDEevpalWuiZUj7ApZU0Re6Y=
t1s
QC/LW/EK2loZCm6fmZFx6zkYHaWRnNGOb3S5L0+BYHUhiPV6FF66PSOaSlqfRd0SHAWNDf4p/=
LNf
tiC3SBvO+IZu1IHazUyHScB22j1F0hiLeAItCHdpu3CTrOqwdEGnUgePI2rrSexRK17ijX6ZE=
GgH
oju5OTGok+bKfCmYChpiQ3YxE7wLU7T1h3gfcCAUZkFemhVumHxDuETfdj1SsSV+IOy92Pj4l=
W7W
x088YVa2mOl7kt6hfMsA0BsnZP5jrxSC2w0UJtIqNexEmUsgdHXIdBurZV1QOaxRlpFswsGOB=
BMB
CAA4AhsBBQsJCAcCBhUICQoLAgQWAgMBAh4BAheAFiEEuPvz8KtWTuhPf7HTk90gYwkQtRUFA=
ltL
fU8ACgkQk90gYwkQtRUXrRAAlmgonnRA/mOmabOSEBPY6dWAmqkABAu/LI+AC3lOJHWd+Tm3v=
fbs
kNKv77z5ZxYoJKe8ngQz/sDxx3Otd/zjZGs/r10iLc+aBwreqNkLnpQ1/HCgg+M3sZoj38rCQ=
8E3
MJoPKD53zKpqG//e5dSKE535IFj2I34449glJFyCU2Mdd6umxxWEPBQbq/D0VjLfsTpWSN9x7=
EAj
I3PmpHQP1C3JaWrg+uJ2C/2tJGpFIL/cIGdGhE/vlTqQT0EH738ySRSrARFpmXbTKpfF4Ms04=
iFL
vaB9wqizQoHQd73pGD8N5bVdzMb1LQgrGTMwKYnTsiZwnNwSRJX94O4FdVuuzZ6hpuFPCo9Lq=
BuD
B4f2dK2qn6zVa28Cj1Q3i5AYJHQ7nfU7kx9+WnU2Dx0BBmqH+c6jiZNIzmWAtA+UwirBnkZwk=
kfl
kWCy74nzUIcmi5kxgNXcNxVILCo3u8nUT9MqTJziaS2BUUoJLptfAu3gX4JPSkalxYJSK4e4d=
m68
lBMr0eK+IAAYveurlNk53xjmWqQx28IBCv9ne/4sS9fQfL2ZbwTUHaSmtsjvRKv6Hg1fL2c1a=
/Q4
cKQRHAMO17GlwH7x93jLbYj+gyRlc47tG1lA7tF6qOD4SZWJuK5qO2wJeRE4QFLbXFCc9a7ku=
3JO
ls57hcKnd54mF9PNEstq5bbOwE0EW0t7AwEIAOA7WMwe9wVGMTGlNoGxU6z8F7g22vjYC6Whf=
NDz
1yV2nHWKCpJVcg9t705Ob8NQLzGHt9mNeqoC5Jq/Pm0vSpS5qYDZ+azFszqiq/zfptgxu3plg=
IN5
FY0UZCRDbNWkGaFCBSRQcZVWdjrlEmB71ro3o9dQixZMUKPRH2t+UABHosxBrY4YxHeDlE+Yj=
7sc
a+ckP+yAffKE09e1AbOtmwyMohvA4brPrRvCWQLz74faTDAIHFn/gbLuANNK/l8qI6tOqZwTG=
u+P
HpVdQaOPAYNKRFZ3BckPWEhIi7XYMJ6ulvBNNJAExlaTdX2n78RkS1T30G36yk4k5AttdC+57=
9sA
EQEAAcLBfAQYAQgAJgIbDBYhBLj78/CrVk7oT3+x05PdIGMJELUVBQJev/bJBQkFxb7GAAoJE=
JPd
IGMJELUV0e8QALOYmuyRwi5rIONihFqDCFyNj/FPiuJTemMgcEldk/ZBVrbKBq+iAO4UnTRy3=
4G/
gUp77KqiXgzEkfWfg8yZRZh6F+zb/WWN+MViLa3jXEphVQtw+Yey12V+YDoMshhR8j2E52BRl=
0G3
hD7C0/iwPqQAswwXg5ZcRyVWMkmytVBIHKOlKA5yFowOhoQlV+tdq/OBIn+K0XZFbqxxVjEWC=
/cr
VaOQb5j9Ibkfzr3QW04SMFBZ9jHBv2fXx8WaM+kUkl7brQO2G/RXaS2waMGUnuwKxlMadyXjm=
KUY
JW+eopWP6I0ksv4EjwZECUaOndp1muGAmR9TecIkNCzeC96eDeLR4lc57WoFLN6kWgz5Mt0ej=
gww
zMc+nrUUyFGMrkbL73ZOi9q1a5tftTQmeIOmnlunkjbAFzwxfgPKEuqBhJNdGuoJsmy5qyMQb=
AZu
RHbj8mdZBAN63DGifpnI2hAtpM1U1vA6XXTjEB3/ey0Mf4gSz+5PGpsdAZ9E9j3qkO1XU+LtL=
wIX
wOE6opKJJ1gTxEtxi3Y//BI8vVqpPIW50SrXgopHGm25vt992akGpUtgB6cQjlee0wH7AOev7=
Zip
gQa3Qe3x1Or4umo5MJRhxE5H7REmAMhLnbTlJ0HcWSeQatWS8x6wnybc/2XPcIcW1xEDMcFR3=
koN
GyK62hwOj6q9wsF8BBgBCAAmAhsMFiEEuPvz8KtWTuhPf7HTk90gYwkQtRUFAl0E2QUFCQOak=
YIA
CgkQk90gYwkQtRUEfQ//SxFjktcASBIl8TZO9a5CcCKtwO3EvyS667D6S1bg3dFonqILXoMGJ=
LM0
z4kQa6VsVhtw2JGOIwbMnDeHtxuxLkxYvcPP6+GwQMkQmOsU0g8iT7EldKvjlW2ESaIVQFKAm=
XS8
re36eQqj73Ap5lzbsZ6thw1gK9ZcMr1Ft1Eigw02ckkY+BFetR5XGO4GaSBhRBYY7y4Xy0WuZ=
Cen
Y7Ev58tZr72DZJVd1Gi4YjavmCUHBaTv9lLPBS84C3fObxy5OvNFmKRg1NARMLqjoQeqLBwBF=
OUP
cL9xr0//Yv5+p1SLDoEyVBhS0M9KSM0n9RcOiCeHVwadsmfo8sFXnfDy6tWSpGi0rUPzh9xSh=
5bU
7htRKsGNCv1N4mUmpKroPLKjUsfHqytT4VGwdTDFS5E+2/ls2xi4Nj23MRh6vvocIxotJ6uNH=
X1k
Yu+1iOvsIjty700P3IveQoXxjQ0dfvq3Ud/Sl/5bUelft21g4Qwqp+cJGy34fSWD4PzOCEe6U=
gmZ
eKzd/w78+tWPvzrTXNLatbb2OpYV8gpoaeNcLlO2DHg3tRbe/3nHoU8//OciZ0Aqjs97Wq0Za=
C6C
dq82QNw1dZixSEWAcwBw0ej3Ujdh7TUAl6tx5AcVxEAmzkgDEuoJBI4vyA1eSgMwdqpdFJW2V=
9Lb
gjg52H6vOq/ZDai29hjCwXYEGAEIACAWIQS4+/Pwq1ZO6E9/sdOT3SBjCRC1FQUCW0t7AwIbD=
AAK
CRCT3SBjCRC1FdQPD/9mUbTho+I+5Fdy55KC40R2W9ShTsRA95C3r37uBnA37T6Mf8X28efeH=
c7R
RQX4eRpKMmoNMM0geW1oQ5rhqX9umAJkdSO/rKrpZ2+Oy6HohehcKm1cRYoLw49rllZFzMhoa=
lNj
jITCRiLTBMy8Vgg7VY9poCpRYjunrdeoigLmrRgHwQtjHBVa6R7OlTD66bG6/P+SyTQkcCx9e=
NMy
dgcZio7K77mB1lyXsdz4ikOeN5O7uPAwlNRYT/e6bIyROudLHmXT+Fkijsg7mZyJiJun1oAaG=
kYB
6Z0uk6AVjy1Cd7/aTGBU/4+CnOnzYs55UNJ4deMdFLyuGdTxa7vR8YLvnYunALN2xLnexRF+h=
8B5
cTDwDoJtzDWKASLbWs6LdUh4LHAOiejNVAzyF0FbmN8mbCfn3w/Qw8RJLHdnUxDeie6ik1yey=
v0u
7a3lsU3bz2fsAz1RUa+uWg38UozJHMKVFUWxzUpEXBVoc0tjDyOXBOVHy2BnhA1RiPRAOuh/8=
i11
lnQpyaadJgoAKOrBsq6IJRqdpUkOJvJOtCaLS/DP/Q/IgBaxoXilBnvx1HADQH+MR7BjdEMDU=
E7L
fl2f2Ab6qvR9uRhj1hlgWKTWn89g4EWfRr/y0Wnx4+xkZAC4t0AA1wl2iLJ4ZR6OS2xYc7DDg=
LBU
m92DF40ru3IjdrOags7ATQRbS3txAQgA5mqcJOegV5MWglTaYd0QwCGx+HtfjBM8VHLjw7vTL=
g8U
OCKeDAROryeO8AEwMaM377TQXxxnjkc00Hl5QoNxb1sGbGu0Ir4XTI+7l/L7Qzg22jDc/Icw0=
i05
Ygp3/8RrM4qK4dquFzp/U6ASsxKF7/2tOaVOirHBWZ+ceLVorrC9VtOI2AbK37YWADoFAigKG=
Q8Y
1DqmBXlCUIRa/Ft7KKhs5IDHV2Kux+iAnBxO+wJT9BpO58Aj1A7x2d7pIqynnPnzKKBY/AOc4=
X8u
9Dbp4OtgeOeTuRW4FUhaMqWmIBDTSF8tTu/BAfSidx8HkdP98vVvbjrWGbBfF5X6MTNCSQARA=
QAB
wsKyBBgBCAAmAhsCFiEEuPvz8KtWTuhPf7HTk90gYwkQtRUFAl6/9soFCQXFvlgBQMB0IAQZA=
QgA
HRYhBMs9P7gHHficF5sLQ/G3Z4WcsuvHBQJbS3txAAoJEPG3Z4WcsuvHdVoH/A2m8fbyqNbrG=
4Ax
5eC2c6yYX0ZtiN/ieRU26CybBXvI6UTXH+nhiaRi3lt7P8KlnfHGLC7W8yWtc56M9xMD4R2iB=
5sF
8OE4GJvjVbtgpvXYNmizUI/IWjXzj4SBqq+bp74Z5cK2xvmI5dHq9rAHQec15SMfISIx6HzCS=
KFu
Mge/U+HmbHhcq8APjniOqSU4ENXWl5TqYdumRrpTMvvqb4iD/wG+ezyfNfw00j1l6phHu9py1=
uY1
il3h20zGh/SlTXcSQiJfGWYKuMzdprJ6ZYifhKDVYBjoCokXJHhpZFrXHs0NCK+cgWgAZFVWQ=
ksn
WHxE0ie06xcGNcEMMghXC+8JEJPdIGMJELUVMJYP/395wAMaYBsT+cW/jXPnOl9Q5FlBYwVbj=
BCe
ssGBp2/k1sd7b9ZivD535u5qfzpwy4Fbj3aRVP2wcp94tGyut3CXA03lyjTaRjpy2utPm8MVq=
cD0
beAcdRsIpdXd25turPJkHbWNkMhpjvy/MGwwaTxW6oKJgR4/aYmuznk1sbHSAUCcYEvZMN4kh=
9OO
c+8QGaWkG8njx/SUfx7CUaLIQYKbMpWhDY4d1XHm5RQN7m/ohWae0z4M4NmHN9JjIwxtE6Iro=
rGo
YF0fJAPvQIJG173zNiFvst11hXYAszYa2zmMrfI/aJdW+28nvOBDphgTvqQYLIIXFkqiPbr3Q=
tnb
e+IXhdL1snfkwunUCeQJehfF647O6whNwrHn0lzOZYNZvZNTAbc0SUxShesFVrGhKD/Ik7yOb=
8JN
10uvvOrh7erTa4xUhIT7styuFvQADWxUdRk29iwf6Swl2sLJzOZkqNyelnXHNMiAIlMQimmA7=
ygZ
mjqr1KNktLQojqEwtpjBGr8s81nIOYx3x9VW+auaXJpximRDgU0W6pqZck7tnyFtMHVaCVEJ0=
w1t
WL4v19raAnWlPfgtwpE/9qp2odHRK9zgHXu9fOGSaeN92nhI7nAYYyHPucHUkjsKMJFF/4efI=
XOF
/FRW+k1kJirXyIoUHOKVk0ouOH2yXLj4OsIJSnZywsKyBBgBCAAmAhsCFiEEuPvz8KtWTuhPf=
7HT
k90gYwkQtRUFAl0E2QUFCQOakRQBQMB0IAQZAQgAHRYhBMs9P7gHHficF5sLQ/G3Z4WcsuvHB=
QJb
S3txAAoJEPG3Z4WcsuvHdVoH/A2m8fbyqNbrG4Ax5eC2c6yYX0ZtiN/ieRU26CybBXvI6UTXH=
+nh
iaRi3lt7P8KlnfHGLC7W8yWtc56M9xMD4R2iB5sF8OE4GJvjVbtgpvXYNmizUI/IWjXzj4SBq=
q+b
p74Z5cK2xvmI5dHq9rAHQec15SMfISIx6HzCSKFuMge/U+HmbHhcq8APjniOqSU4ENXWl5TqY=
dum
RrpTMvvqb4iD/wG+ezyfNfw00j1l6phHu9py1uY1il3h20zGh/SlTXcSQiJfGWYKuMzdprJ6Z=
Yif
hKDVYBjoCokXJHhpZFrXHs0NCK+cgWgAZFVWQksnWHxE0ie06xcGNcEMMghXC+8JEJPdIGMJE=
LUV
kVwP/18ljntddAENT0iipPFe+vpPReM+Dtqdg1MLLDdpcJb8yscBXb8wAr1bbFtdaYzK+GJ3N=
0Ye
DzRXd4m5zhe9C2u8rceMPGHtmkX2NRVDf2Mo1hGDaUeDrWDFg3fFz8nvcPDyS6d6y9lLZ8cfM=
bUe
uPaha/fFRuH6+9HUrJql3mF7xHTuve+YbuIJCiM1gGt9UPdmB6cSZsaz18zWH6fU75iFY6DE9=
dbJ
8gwh/tZM55jSKfgIOrbKAl9ZpKfoWB3gX9RVmNEZfQlNH9PATlLbLKvVD/y9SpQ7zCGAJ26aa=
kLz
khNm+Ajwg5YzKQ/4dlKipQrJuwWWtfur3fKSRY1kpyTtTsYV7/EKJrG/HI+Du8C4wsM7KSo1n=
XAl
jOhCRrWQmLpGYEWkNBSDv789LqUIWgSmlant5RJI0+bxUVuPBrUPcyBLf5VIo4yYVYZEJj31t=
aeX
Zl3aN90ROYEU1cD3iaDY3a8j9MeO7v27V1H2DOmMftHeOY++kRzZYJTm4l9pWgASqH2QjYPs2=
VAI
bzRSRcMcaZygcGeyIRkaPObnNg5iKeNNR6jLcXTxpNn57+yP6vhVM5QH9vSPL4k+fGfbcWS0Y=
hid
D6UuwCSZxtwPAKinhXn3B5HZ6rAGp501FRfk5M/3eVQiGtEjLdxlP8Dmc1xR4JhFLxsJEUqtA=
oSf
3ZEWwsKsBBgBCAAgFiEEuPvz8KtWTuhPf7HTk90gYwkQtRUFAltLe3ECGwIBQAkQk90gYwkQt=
RXA
dCAEGQEIAB0WIQTLPT+4Bx34nBebC0Pxt2eFnLLrxwUCW0t7cQAKCRDxt2eFnLLrx3VaB/wNp=
vH2
8qjW6xuAMeXgtnOsmF9GbYjf4nkVNugsmwV7yOlE1x/p4YmkYt5bez/CpZ3xxiwu1vMlrXOej=
PcT
A+EdogebBfDhOBib41W7YKb12DZos1CPyFo184+Egaqvm6e+GeXCtsb5iOXR6vawB0HnNeUjH=
yEi
Meh8wkihbjIHv1Ph5mx4XKvAD454jqklOBDV1peU6mHbpka6UzL76m+Ig/8Bvns8nzX8NNI9Z=
eqY
R7vactbmNYpd4dtMxof0pU13EkIiXxlmCrjM3aayemWIn4Sg1WAY6AqJFyR4aWRa1x7NDQivn=
IFo
AGRVVkJLJ1h8RNIntOsXBjXBDDIIVwvvwjsP/1QDdPUYl5sX1AbOit/DUBxZmsRu/aSvTWZN2=
ZzD
rkp3oE3wanA9yYxg2VhC9QIWw6agD0eJ/b3Z9RjWXWzRphXIEXBpk1uRyeJdjzRfSMgSaZVol=
yL8
82unkZGDdbjHsNcWxQqLbJQJeTljtgINx7ZwmGoD6ZD6eoMS+Ogu+gkVRoIMi8L4EE/0OCOsn=
Wz+
tgBJiK1KyeSg2YCu3a6YAnxU5j7tDZKxV+XO5cqeaOceRdG6HyyvHLNyT9r0SiZtpK99GlXYr=
SeY
Hyp1c3Epa1ZPQ3/sps6U+SqRkoEBlKBNcEQuqGaLtKBQNzgXycTBHdGeNlGx6Xx+XJCgivmqn=
YpY
nhu4r1zk6KNhGG83yMWnD+zvPuYz03c+cdCrI5wgrWPqWoxCML+SZEqk37ROtozPyVfxMj102=
3L9
cW5W31j1i/W99IUdkRipZB9EUBhIgD+i8FvsJEGjxJ3idsuTvP7tD+07VnL9dL5QanCAG1DJ/=
RZM
LZYNIr+CZPAWFa9rj7X0oa6pbhN4NqIq1qSL82sfAIfdo5bHTGvGPhWvapUQ71CSyT7hFm3ZA=
tf0
8KWYMNlH8qCcAYhVodzDo6efTaRrv5X1zwNwmNCkPojKwjSvhTQsJQx123CpoOT/QtHwzf4uF=
DvT
6RZEIBjRAJlrmkJT0rY/b6fPuKziwXWE1Vqv
=3D2yDv
-----END PGP PUBLIC KEY BLOCK-----

--------------EEEDDA11A3D401DCE99FFCAF--

--t7Fw5ro5HQMuBV8Z2y77w5eqNhCWwieGd--

--47iPhsoSMa5R1UOoUKl1pXXFij00xLtk0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAmCRvyEACgkQ8bdnhZyy
68cRxggAnGz9cxKSoFkDZYyO6RXmInaqfLMGgzGzggGbG+lzAlxug8X8/OM1TMsE
OwjEuV5Vg3/m7TW3xcCLsV6ejHnbNm+5wd2e36JmGYjlqnddG4SqjKOCsxTorSiA
8glUMe0p6AaZxgpaoYGlbvv5xcUuTT5q4LGNGsUt4i2s9yyYGe6DhEqrCw41U/Sx
CGt53i4jU8RLIYcxuBjB/Kd33wJlzvHVeaqUuPxY0NKNnbvJsM2k/vWpkrylq22M
bSZsYC4bgmTt9jaxNhIwc3lc4PSxyt8cP1R5mbIa8l/oNrzuA/kdoqvcoW+hTJeq
5pZFpDkiw0Tv/LngFMzS8Ah9Uk4xLg==
=FxHz
-----END PGP SIGNATURE-----

--47iPhsoSMa5R1UOoUKl1pXXFij00xLtk0--
